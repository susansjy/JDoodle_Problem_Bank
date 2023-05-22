import { Injectable } from '@nestjs/common';
import axios from "axios";

@Injectable()
export class AppService {
  getWebSocketToken(clientId, clientSecret) {
    return axios.post("https://api.jdoodle.com/v1/auth-token", {
        clientId: process.env.JDOODLE_CLIENT_ID,
        clientSecret: process.env.JDOODLE_CLIENT_SECRET,
    });
  }

  postExecute(script, language, versionIndex) {
    return axios.post("https://api.jdoodle.com/v1/execute", {
        script,
        language,
        versionIndex,
        clientId: process.env.JDOODLE_CLIENT_ID,
        clientSecret: process.env.JDOODLE_CLIENT_SECRET,
    });
  }
}
