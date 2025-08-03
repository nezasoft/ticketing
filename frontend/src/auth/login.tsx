import React, { useState, useContext } from 'react';
import { AuthContext } from '../context/AuthContext';
import { useNavigate, Link } from 'react-router-dom';
import { SettingContext } from '../context/SettingContext';



const Login: React.FC = () => {
  const { login } = useContext(AuthContext);
  const navigate = useNavigate();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [rememberMe, setRememberMe] = useState(false);
  const [showPassword, setShowPassword] = useState(false);
  const [loading, setLoading] = useState(false);
  const [feedback, setFeedback] = useState<{ type: 'success' | 'error'; message: string } | null>(null);
  const {listSettings}  = useContext(SettingContext);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setFeedback(null); // Clear previous message
    try {
      const response = await login(email, password);
      if (response.success) {
        // 1. Login succeeded
      const user = response.data.user;
         // 2. Fetch and store settings
      const settingsResp = await listSettings(user.company_id);
      if (!settingsResp.success) {
        setFeedback({ type: 'error', message: 'Failed to load settings' });
        return;
      }

      //Decode and save token
        setFeedback({ type: 'success', message: 'Login successful!' });
        navigate('/dashboard');
      } else {
        setFeedback({ type: 'error', message: response.message || 'Login failed.' });
      }
    } catch (error) {
      setFeedback({ type: 'error', message: 'An error occurred. Please try again.' });
      console.error('Login Error:', error);
    } finally {
      setLoading(false);
    }
  };

  

  return (
    <div className="h-screen grid grid-cols-1 md:grid-cols-2 dark:bg-zinc-900 text-gray-800 dark:text-white">
      {/* Left Panel */}
      <div className="flex flex-col justify-center px-10">
        <div className="mb-8">
          <div className="flex items-center mb-4">
            <div className="w-8 h-8 rounded shadow-md flex items-center justify-center text-white mr-2">
              <img src="logo.png" alt="Logo" className="w-6 h-6 ltr:mr-2 rtl:ml-2" />
            </div>
            <h1 className="text-2xl font-bold text-gray-900">Oris RT</h1>
          </div>
          <h2 className="text-xl font-semibold mb-1">Welcome Back !</h2>
          <p className="text-sm text-gray-500">Sign in to continue to Oris RT.</p>
        </div>
        {feedback && (
        <div
          className={`text-sm font-medium p-2 rounded-md ${
            feedback.type === 'error' ? 'text-red-700 bg-red-100' : 'text-green-700 bg-green-100'
          }`}
        >
          {feedback.message}
        </div>
      )}


        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700">Email</label>
            <input
              type="text"
              placeholder="Enter email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className="mt-1 block w-full p-2 rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"
              required
            />
          </div>

          <div>
            <div className="flex items-center justify-between">
              <label className="block text-sm font-medium text-gray-700">Password</label>
              <Link to="/recover" className="text-indigo-600 hover:underline font-medium">
                Forgot password?
              </Link>
            </div>
            <div className="relative mt-1">
              <input
                type={showPassword ? 'text' : 'password'}
                placeholder="Enter password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                className="block w-full p-2 rounded-md border-gray-300 shadow-sm pr-10 focus:border-indigo-500 focus:ring-indigo-500"
                required
              />
              <div
                className="absolute inset-y-0 right-0 pr-3 flex items-center cursor-pointer"
                onClick={() => setShowPassword(!showPassword)}
              >
                <svg className="h-5 w-5 text-gray-400" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24">
                  <path d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                  <path d="M2.458 12C3.732 7.943 7.522 5 12 5s8.268 2.943 9.542 7c-1.274 4.057-5.064 7-9.542 7S3.732 16.057 2.458 12z" />
                </svg>
              </div>
            </div>
          </div>

          <div className="flex items-center">
            <input
              id="remember-me"
              type="checkbox"
              checked={rememberMe}
              onChange={(e) => setRememberMe(e.target.checked)}
              className="h-4 w-4 text-indigo-600 focus:ring-indigo-500 border-gray-300 rounded"
            />
            <label htmlFor="remember-me" className="ml-2 block text-sm text-gray-900 font-medium">
              Remember me
            </label>
          </div>

          <button
            type="submit"
            disabled={loading}
            className={`w-full font-medium py-2 rounded-md shadow mb-2 ${
              loading
                ? 'bg-indigo-400 cursor-not-allowed'
                : 'bg-indigo-600 hover:bg-indigo-700 text-white'
            }`}
          >
            {loading ? (
            <div className="flex justify-center items-center">
              <svg className="animate-spin h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8z"></path>
              </svg>
            </div>
          ) : 'Log In'}

          </button>

          <p className="text-sm text-center text-gray-600">
            Don't have an account?{' '}
            <Link to="/register" className="text-indigo-600 hover:underline font-medium">
              Register
            </Link>
          </p>
        </form>
      </div>

      {/* Right Panel */}
      <div className="relative hidden md:block">
        <div className="absolute inset-0 bg-blue-700 bg-opacity-60"></div>
        <img
          src="https://images.unsplash.com/photo-1556740749-887f6717d7e4"
          alt="Office"
          className="w-full h-full object-cover"
        />
        <div className="absolute bottom-4 right-4">
          <button className="bg-indigo-500 text-white px-4 py-1 rounded-full text-sm">RTL</button>
        </div>
      </div>
    </div>
  );
};

export default Login;
