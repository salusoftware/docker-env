const express = require('express');
const { exec } = require('child_process');
const app = express();
app.use(express.json());

app.post('/webhook', (req, res) => {
    if (req.body?.ref === 'refs/heads/main') {
        exec('/home/salusoftware/docker-env/deploy.sh', (err, stdout, stderr) => {
            if (err) {
                console.error(`Erro: ${err.message}`);
                return res.sendStatus(500);
            }
            console.log(stdout);
            res.send('✅ Deploy executado');
        });
    } else {
        res.status(200).send('Branch ignorada');
    }
});

app.listen(4000, () => console.log('📣 Webhook rodando na porta 4000'));