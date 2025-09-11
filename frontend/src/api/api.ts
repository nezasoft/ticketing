import axios from "axios";
import { tokenManager } from "../utils/tokenManager";

const api = axios.create({
  baseURL: process.env.REACT_APP_API_URL || "http://localhost:7000/api",
});

// Attach token before each request
api.interceptors.request.use(
  (config) => {
    const token = tokenManager.getToken();
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => Promise.reject(error)
);

export default api;
