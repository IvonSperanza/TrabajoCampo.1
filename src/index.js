require('dotenv').config();
const express = require('express');
const cors = require('cors');
const morgan = require('morgan');

const app = express();

app.use(cors());
app.use(morgan('dev'));
app.use(express.json());

//MONTANDO RUTAS

const authRoutes = require('./routes/auth.routes');
app.use('/api/auth', authRoutes);

app.get('/', (_req, res) => res.json({ message: 'FMC API up' }));
app.get('/api/health', (_req, res) => res.json({ ok: true, ts: new Date().toISOString() }));

app.use((req, res) => res.status(404).json({ error: 'Not Found', path: req.originalUrl }));
app.use((err, _req, res, _next) => { console.error(err); res.status(500).json({ error: 'Internal Server Error' }); });

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`API running on http://localhost:${PORT}`));
