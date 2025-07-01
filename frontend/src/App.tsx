import React from 'react';
import {BrowserRouter as Router,Routes,Route,Navigate,} from 'react-router-dom';
import { AuthProvider, AuthContext } from './context/AuthContext';
import Login from './auth/Login';
import Register from './auth/Register';
import RecoverPassword from './auth/RecoverPassword';

import Dashboard from './pages/Dashboard';
import Tickets from './pages/Tickets';
import TicketView from './pages/TicketView';
import TicketForm from './pages/TicketForm';

// A simple private route wrapper for React Router v6
const PrivateRoute: React.FC<{ children: React.ReactElement }> = ({ children }) => {
  const { token } = React.useContext(AuthContext);
  return token ? children : <Navigate to="/login" replace />;
};

const App: React.FC = () => {
  return (
    <AuthProvider>
      <Router>
        <Routes>
          <Route path="/login" element={<Login />} />
          <Route path="/register" element={<Register />} />
          <Route path="/recover" element={<RecoverPassword />} />
          <Route
            path="/dashboard" element={
              <PrivateRoute>
                <Dashboard />
              </PrivateRoute>
            }
          />
          <Route
            path="/tickets" element={
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
          <Route path="/" element={<Navigate to="/dashboard" replace />} />
        </Routes>
      </Router>
    </AuthProvider>
  );
};

export default App;
