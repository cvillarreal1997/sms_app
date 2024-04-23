const express = require('express');
const bodyParser = require('body-parser');

const app = express();

// Middleware
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

// Rutas
// Define tus rutas aquí

// Puerto
const port = process.env.PORT || 3000;
app.listen(port, () => {
    console.log(`Servidor corriendo en el puerto ${port}`);
});
app.post('/sms', (req, res) => {
    const { message } = req.body;

    // Expresión regular para buscar un número de cualquier cantidad de dígitos en el mensaje
    const regex = /\b\d+\b/g;
    const matches = message.match(regex);

    if (matches && matches.length > 0) {
        console.log('Números encontrados en el mensaje:');
        matches.forEach((match, index) => {
            console.log(`Número ${index + 1}: ${match}`);
            
            // Aquí puedes realizar acciones adicionales con cada número encontrado, según sea necesario.
        });

        res.status(200).send('Mensaje procesado correctamente');
    } else {
        console.log('No se encontraron números en el mensaje');
        res.status(400).send('El mensaje no contiene ningún número válido');
    }
});