import React, { useEffect, useState, useContext } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { AuthUser } from '../types';
import Sidebar from '../components/Sidebar';
import Navbar from '../components/Navbar';
import { ArrowPathIcon, ArrowLeftIcon } from '@heroicons/react/24/outline';
import { SettingContext } from '../context/SettingContext';
import UserDetail from '../components/users/UserDetail';

const UserView: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [user, setUser] = useState<AuthUser | null>(null);
  const [loading, setLoading] = useState<boolean>(true);

  const { viewUser } = useContext(SettingContext); // Extract only the function
  useEffect(() => {
    const userId = parseInt(id ?? '');
    if (!id || isNaN(userId)) return;

    const fetch = async () => {
      setLoading(true);
      try {
        const response = await viewUser(userId);
        if (response.success && response.data) {
          setUser(response.data);
        } else {
          console.error('User fetch failed:', response.message);
        }
      } catch (err) {
        console.error('Fetch error:', err);
      } finally {
        setLoading(false);
      }
    };

    fetch();
  }, [id, viewUser]); // Only depends on stable references

  if (!id || isNaN(parseInt(id))) {
    return (
      <div className="flex flex-col items-center justify-center h-screen bg-white dark:bg-zinc-900 text-gray-800 dark:text-white">
        <p className="text-lg font-medium text-red-500">Invalid User ID</p>
        <button
          onClick={() => navigate('/users')}
          className="mt-4 px-4 py-2 bg-violet-600 text-white rounded hover:bg-violet-700"
        >
          Go back to Users
        </button>
      </div>
    );
  }

  if (loading) {
    return (
      <div className="flex flex-col items-center justify-center h-screen bg-white dark:bg-zinc-900 text-gray-800 dark:text-white">
        <ArrowPathIcon className="h-10 w-10 animate-spin text-violet-600 mb-4" />
        <p className="text-lg font-medium">Loading...</p>
      </div>
    );
  }

  if (!user) {
    return (
      <div className="flex flex-col items-center justify-center h-screen bg-white dark:bg-zinc-900 text-gray-800 dark:text-white">
        <p className="text-lg font-medium text-red-500">User not found</p>
        <button
          onClick={() => navigate('/users')}
          className="mt-4 px-4 py-2 bg-violet-600 text-white rounded hover:bg-violet-700"
        >
          Go back to Users
        </button>
      </div>
    );
  }

  return (
    <div className="flex dark:bg-zinc-900 text-gray-800 dark:text-white">
      <Navbar />
      <Sidebar />
      <main className="md:ml-[250px] md:mt-[70px] p-4 w-full h-full">
        <div className="flex flex-wrap items-center justify-between mb-4">
          <h2 className="text-xl font-semibold">Users</h2>
        </div>
        <button
          onClick={() => navigate(-1)}
          aria-label="Go back"
          className="mb-4 p-2 bg-violet-500 text-white rounded-full hover:bg-violet-600"
        >
          <ArrowLeftIcon className="h-4 w-4" />
        </button>
        <UserDetail />
      </main>
    </div>
  );
};

export default UserView;
