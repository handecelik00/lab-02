const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

app.get('/health', (req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

app.get('/items', (req, res) => {
  res.json([
    { id: 1, name: 'Cloud' },
    { id: 2, name: 'Scale' },
    { id: 3, name: 'Pain' }
  ]);
});

if (require.main === module) {
  app.listen(PORT, () => console.log(`Running on :${PORT}`));
}

module.exports = app;