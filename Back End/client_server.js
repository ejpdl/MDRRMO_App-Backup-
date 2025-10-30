const express = require('express');
const mysql = require('mysql');
const moment = require('moment');
const cors = require('cors');
const bcrypt = require('bcrypt');
const multer = require('multer');
const path = require('path');
const jwt = require('jsonwebtoken');
const bodyParser = require('body-parser');

const app = express();

app.use(cors());
app.use(express.json());
app.use(bodyParser.json());
app.use('/uploads', express.static('uploads'));
app.use(express.urlencoded({ extended : false }));

const logger = (req, res, next) => {

    console.log(`${req.method} ${req.protocol}://${req.get("host")}${req.originalUrl} : ${moment().format()}`);

    next();

}

app.use(logger);

const JWT_SECRET = 'secret_key';

const authenticateToken = (req, res, next) => {

    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];

    if(!token) return res.sendStatus(401);

    jwt.verify(token, JWT_SECRET, (err, user) => {

        if(err) return res.sendStatus(403);

        req.user = user;
        next();

    });

};

const connection = mysql.createConnection({

    host: "localhost",
    user: "root",
    password: "",
    database: "mdrrmo_app"

});

connection.connect((err) => {

    if(err){

        console.log(`Error Connecting to the database: ${err}`);
        return;

    }

    console.log(`Successfully Connected to the database ${connection.config.database}`);

});

const fileStorage = multer.diskStorage({

    destination: (req, file, cb) => {

        cb(null, 'uploads/');

    },

    filename: (req, file, cb) => {

        cb(null, Date.now() + '--' + file.originalname);

    }

});

const upload = multer({ storage: fileStorage });

app.post('/user/register', async (req, res) => {

    const { firstname, lastname, username, password, address, contact } = req.body;

    const hash = await bcrypt.hash(password, 10);
    const query = `INSERT INTO client_credentials (firstname, lastname, username, password, address, contact) VALUES (?, ?, ?, ?, ?, ?)`;

    connection.query(query, [firstname, lastname, username, hash, address, contact], (err, results) => {

        if(err){

            if(err.code === 'ER_DUP_ENTRY'){

                return res.status(409).json({ error: `Username already exists` });

            }

            return res.status(500).json({ error: `Database Error`, details: err.message });

        }

        const token = jwt.sign({ id: results.insertId, username }, JWT_SECRET, { expiresIn: '1h' });

        res.status(200).json({ message: `User registered successfully`, token });

    });

});

app.post('/user/login', (req, res) => {

    const { username, password } = req.body;
    const query = `SELECT * FROM client_credentials WHERE username = ?`;

    connection.query(query, [username], async (err, results) => {

        if(err || results.length === 0) {
            return res.status(401).json({ error: `Invalid username or password` });
        }

        const user = results[0];
        const isMatch = await bcrypt.compare(password, user.password);

        if(!isMatch) {
            return res.status(401).json({ error: `Invalid username or password` });
        }

        const token = jwt.sign({ id: user.id, username: user.username }, JWT_SECRET, {expiresIn: '1h'});

        res.status(200).json({

            message: `Login Successfull`,
            token: token,

        });

    });

});


app.get('/user/profile', authenticateToken, (req, res) => {

    const userId = req.user.id;
    const query = `SELECT * FROM client_credentials WHERE id = ?`;

    connection.query(query, [userId], (err, results) => {

        if(err) return res.status(500).json({ error: `Database Error`, details: err.message });

        if(results.length === 0) return res.status(404).json({ error: `User not found` });

        res.status(200).json(results[0]);

    });

});


app.put('/user/profile/edit', authenticateToken, (req, res) => {

    const userId = req.user.id;
    const { firstname, lastname, address, contact } = req.body;

    const query = `
    UPDATE client_credentials 
    SET firstname = ?, lastname = ?, address = ?, contact = ? 
    WHERE id = ?`;

    connection.query(query, [firstname, lastname, address, contact, userId], (err, results) => {

        if(err) return res.status(500).json({ error: `Database Error`, details: err.message });

        res.status(200).json({ message: `Profile successfully updated` });

    });

});


app.post('/report/submit', authenticateToken, upload.single('photo'), (req, res) => {

    console.log("BODY:", req.body);  
    console.log("FILE:", req.file); 

    const userId = req.user.id;

    const { region, city, district, street, type_of_accident } = req.body;

    const photoUrl = req.file ? `/uploads/${req.file.filename}` : null;

    const query = `
    INSERT INTO incident_reports
    (user_id, photo_url, region, city, district, street, type_of_accident, status)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    `;

    connection.query(query, [userId, photoUrl, region, city, district, street, type_of_accident, "Pending"], (err, results) => {

        if(err){

            console.error("SQL Error:", err.sqlMessage || err);
            return res.status(500).json({ error: err.sqlMessage || "Database error" });
        
        }

        res.status(201).json({ message: 'Report submitted successfully!' });

    });

});

app.get('/report/logs', authenticateToken, (req, res) => {

    const userId = req.user.id;
    const sort = req.query.sort;
    const search = req.query.search || '';

    let orderBy = ' created_at DESC';

    switch(sort) {

        case 'Date Oldest First':
            orderBy = 'created_at ASC';
            break;
        case 'Date Newest First':
            orderBy = 'created_at DESC';
            break;
        case 'Time Oldest First':
            orderBy = 'created_at ASC';
            break;
        case 'Time Newest First':
            orderBy = 'created_at DESC';
            break;
        case 'Accepted':
        case 'Pending':
        case 'Resolved':
        case 'Denied':
            orderBy = `status = '${sort}' DESC, created_at DESC`;
            break;

    }

    const query = `
     SELECT 
        district AS location,
        DATE_FORMAT(created_at, '%M %d, %Y') AS date,
        TIME_FORMAT(created_at, '%h:%i %p') AS time,
        status
      FROM incident_reports
      WHERE user_id = ? 
    AND (
      district LIKE CONCAT('%', ?, '%') OR
      DATE_FORMAT(created_at, '%M %d, %Y') LIKE CONCAT('%', ?, '%') OR
      TIME_FORMAT(created_at, '%h:%i %p') LIKE CONCAT('%', ?, '%') OR
      status LIKE CONCAT('%', ?, '%')
    )
      ORDER BY ${orderBy}`;

    connection.query(query, [userId, search, search, search, search], (err, results) => {

        if (err) return res.status(500).json({ error: 'Database error', details: err });

        res.json(results);

    });

});






app.get(`/viewAll/contacts`, authenticateToken, (req, res) => {

    const query = `SELECT * FROM emergency_contacts`;
    connection.query(query, (err, results) => {

        if(err) return res.status(500).json({ error: `Database Error`, details: err.message });

        res.json(results);

    });

});





const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {

    console.log(`Server is running at port ${PORT}`);

})