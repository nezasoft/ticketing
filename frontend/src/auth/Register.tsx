import React, { useState } from 'react';
import {Link } from 'react-router-dom';

const Register: React.FC = () => {

  const [email, setEmail] = useState('');
  const [name, setFullName] = useState('');
  const [phone, setPhone] = useState('');
  const [password, setPassword] = useState('');
  const [password_confirm, setPasswordConfirm] = useState('');
  const [agree, setAgree] = useState(true); // assuming pre-checked

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();

    // Simulate form logic or call API
    if (!email || !name || !phone || !password || !password_confirm) {
      alert('Please fill in all fields.');
      return;
    }

    const formData = {
      email,
      name,
      phone,
      password,
    };

    console.log('Registering user:', formData);
    alert('User registered (mock)');
  };

  return (
    <div className="flex min-h-screen">
      {/* Left Panel (Form) */}
      <div className="w-full md:w-1/2 flex items-center justify-center px-6 bg-white">
        <div className="max-w-md w-full space-y-6">
          <div className="mb-8 mt-2">
          <div className="flex items-center mb-4">
            <div className="w-8 h-8 bg-indigo-600 rounded shadow-md flex items-center justify-center text-white mr-2">
              <svg className="w-5 h-5" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24">
                <path d="M12 2L2 7l10 5 10-5-10-5zm0 5l10 5-10 5-10-5 10-5zm0 10l10-5v10L12 22l-10-5V12l10 5z" />
              </svg>
            </div>
            <h1 className="text-2xl font-bold text-gray-900">Oris RT</h1>
          </div>
          <h2 className="text-xl font-semibold mb-1">Register Account</h2>
          <p className="text-sm text-gray-500">Get your Oris RT account now.</p>
        </div>
          <form onSubmit={handleSubmit} className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-700">Name</label>
              <input
                type="text"
                placeholder="Enter Full Name"
                value={name}
                onChange={(e) => setFullName(e.target.value)}
                className="mt-1 p-2 block w-full rounded-md border-gray-300 shadow-sm focus:ring-indigo-500 focus:border-indigo-500"
                required
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700">Email</label>
              <input
                type="email"
                placeholder="Enter Email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                className="mt-1 p-2 block w-full rounded-md border-gray-300 shadow-sm focus:ring-indigo-500 focus:border-indigo-500"
                required
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700">Phone</label>
              <input
                type="text"
                placeholder="Enter Phone"
                value={phone}
                onChange={(e) => setPhone(e.target.value)}
                className="mt-1 p-2 block w-full rounded-md border-gray-300 shadow-sm focus:ring-indigo-500 focus:border-indigo-500"
                required
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700">Password</label>
              <input
                type="password"
                placeholder="Enter password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                className="mt-1 p-2 block w-full rounded-md border-gray-300 shadow-sm focus:ring-indigo-500 focus:border-indigo-500"
                required
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700">Confirm Password</label>
              <input
                type="password"
                placeholder="Confirm password"
                value={password}
                onChange={(e) => setPasswordConfirm(e.target.value)}
                className="mt-1 p-2 block w-full rounded-md border-gray-300 shadow-sm focus:ring-indigo-500 focus:border-indigo-500"
                required
              />
            </div>

            <p className="text-xs text-gray-600">
              By registering you agree to the Oris RT{' '}
              <a href="#" className="text-indigo-600 hover:underline">
                Terms of Use
              </a>
            </p>

            <button
              type="submit"
              className="w-full bg-indigo-600 hover:bg-indigo-700 text-white font-semibold py-2 rounded-md shadow mb-4"
            >
              Register
            </button>
            <p className="text-sm text-center text-gray-600">
              Already have an account?{' '}
              <Link to="/login" className="text-indigo-600 hover:underline font-medium">
                Login
              </Link>
            </p>
          </form>
        </div>
      </div>

      {/* Right Panel (Background) */}
      <div className="hidden md:block w-1/2 bg-indigo-600 bg-cover relative">
        {/* You can use a background image or any overlay */}
        <div className="absolute inset-0 bg-indigo-700 opacity-80" />
        <div className="relative z-10 h-full w-full flex items-center justify-center text-white font-semibold">
          {/* Optional: content or illustration */}
          <span className="absolute bottom-10 right-10 text-sm bg-indigo-800 px-4 py-1 rounded-full">RTL</span>
        </div>
      </div>
    </div>
  );
};

export default Register;
