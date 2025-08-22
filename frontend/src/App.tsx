import React from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import { ToastContainer } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

import AppProviders from './context/AppProviders';
import { AuthContext } from './context/AuthContext';

import Login from './auth/Login';
import Register from './auth/Register';
import RecoverPassword from './auth/RecoverPassword';
import Dashboard from './pages/Dashboard';
import Tickets from './pages/Tickets';
import TicketView from './pages/TicketView';
import TicketForm from './pages/TicketForm';
import Users from './pages/Users';
import UserView from './pages/UserView';
import Departments from './pages/Departments';

const PrivateRoute: React.FC<{ children: React.ReactElement }> = ({ children }) => {
  const { token } = React.useContext(AuthContext);
  return token ? children : <Navigate to="/login" replace />;
};

const App: React.FC = () => {
  return (
    <AppProviders>
      <ToastContainer position="top-right" autoClose={3000} />
      <Router>
        <Routes>
          <Route path="/login" element={<Login />} />
          <Route path="/register" element={<Register />} />
          <Route path="/recover" element={<RecoverPassword />} />
          <Route
            path="/dashboard"
            element={
              <PrivateRoute>
                <Dashboard />
              </PrivateRoute>
            }
          />
          <Route
            path="/tickets"
            element={
              <PrivateRoute>
                <Tickets />
              </PrivateRoute>
            }
          />
          <Route
            path="/tickets/:id"
            element={
              <PrivateRoute>
                <TicketView />
              </PrivateRoute>
            }
          />
          <Route
            path="/create-ticket"
            element={
              <PrivateRoute>
                <TicketForm />
              </PrivateRoute>
            }
          />
          <Route
            path="/users"
            element={
              <PrivateRoute>
                <Users />
              </PrivateRoute>
            }
          />
          <Route
            path="/users/:id"
            element={
              <PrivateRoute>
                <UserView />
              </PrivateRoute>
            }
          />
          <Route
            path="/departments"
            element={
              <PrivateRoute>
                <Departments />
              </PrivateRoute>
            }
          />

          <Route path="/" element={<Navigate to="/dashboard" replace />} />
        </Routes>
      </Router>
    </AppProviders>
  );
};

export default App;
