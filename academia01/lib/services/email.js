
import FormData from "form-data";
import Mailgun from "mailgun.js";
import dotenv from "dotenv";
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
dotenv.config({ path: path.join(__dirname, "..", "..", ".env") });


/**
 * @param { string } emailDestinatario
 * @param { string } codigo
 */
export async function sendCodigoEmail(emailDestinatario, codigo) {
    const emailAutorizado = process.env.EMAIL_USERNAME;
    const mailgunKey = process.env.MAILGUN_KEY;
    const mailgun = new Mailgun(FormData);
    const mg = mailgun.client({
        username: "api",
        key: mailgunKey,
    });

    try {
        const data = await mg.messages.create(process.env.MAILGUN_DOMAIN, {
            from: `Mailgun <${process.env.EMAIL_USERNAME}>`,
            to: [`Nome do destinatário <${emailDestinatario}>`],
            subject: "Seu código de recuperação",
            text: `Seu código de recuperação é: ${codigo}`,
        });
        console.log(data);
        return true;
    } catch (error) {
        console.log(error);
        return false;
    }
}

