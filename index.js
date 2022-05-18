let catalog = require('./catalog.json');

const express = require('express');
const app = express();
const port = 3000;

app.get('/*', (req, res) => {
    let response = null;

    let catalogEndpoint = catalog[req.params[0]];
    if (catalogEndpoint) {
        response = catalogEndpoint;
    }

    if (response === null) {
        res.sendStatus(404);
    } else {
        res.send(response);
    }
});

app.listen(port, () => {
    console.log(`Listening on port ${port}`);
});
