import React, { useState, useContext } from 'react';
import {
  EnvelopeIcon,
  TrashIcon,
  EllipsisVerticalIcon,
  ArrowRightCircleIcon,
  StarIcon,
  UserCircleIcon,
  PencilSquareIcon,
  CalendarDaysIcon,
  PaperAirplaneIcon,
  LockClosedIcon
} from '@heroicons/react/24/solid';
import { toast } from 'react-toastify';
import { Attachment, Reply } from '../types';
import { TicketContext } from '../context/TicketContext';
import ReplyCard from './ReplyCard';
import AttachmentList from './AttachmentList';
import EventCard from './EventCard';
import ReplyForm from './ReplyForm';

interface TicketDetailProps {
  ticket_id: number;
  subject?: string;
  description: string;
  attachments?: Attachment[];
  replies?: any[];
  events?: any[];
  status?: string;
  priority?: string;
  ticket_no?: string;
  created_at?: string;
  phone?: string;
  email?: string;
  channel?: string;
}

const TicketDetail: React.FC<TicketDetailProps> = ({
  ticket_id,
  subject,
  description,
  attachments = [],
  replies = [],
  events = [],
  status,
  priority,
  ticket_no,
  phone,
  email,
  channel,
  created_at
}) => {
  const { replyTicket } = useContext(TicketContext);
  const [showReplyForm, setShowReplyForm] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [replyList, setReplyList] = useState(replies);

  const handleReplySubmit = async (message: string, files: File[]) => {
    const storedUser = localStorage.getItem('user');
    const parsedUser = storedUser ? JSON.parse(storedUser) : null;

    if (!ticket_id || !parsedUser?.id) {
      toast.error('Missing user or ticket ID');
      return;
    }

    try {
      setIsSubmitting(true);

      const formData = new FormData();
      formData.append('ticket_id', ticket_id.toString());
      formData.append('user_id', parsedUser.id.toString());
      formData.append('description', message);
      files.forEach((file, index) => {
        formData.append(`attachments[${index}]`, file);
      });

      const response = await replyTicket(formData);

      if (response.success) {
        toast.success('Reply sent successfully');
        setShowReplyForm(false);
          // Append the new reply to the list
          setReplyList(prev => [
            ...prev,
            {
              reply_message: message,
              reply_at: new Date().toISOString(),
              user: parsedUser?.name || 'You',
              email: parsedUser?.email
            }
          ]);
      } else {
        toast.error(response.message || 'Failed to send reply');
      }
    } catch (error: any) {
      toast.error(error.message || 'Unexpected error occurred');
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="rounded-xl mt-4 bg-white shadow-sm dark:bg-zinc-900 text-gray-800 dark:text-white">
      <div className="bg-gray-100 px-4 py-3">
        <h5 className="flex items-center gap-2 text-lg font-medium text-gray-800">
          <EnvelopeIcon className="w-5 h-5" />
          <span>{subject || 'No subject provided'}</span>
        </h5>
      </div>

      <div className="p-4">
        <div className="flex flex-col md:flex-row justify-between items-start md:items-center mb-4 gap-4">
          <div className="flex items-center gap-3">
            <UserCircleIcon className="w-16 h-16" />
            <div>
              <p className="text-sm font-semibold text-gray-800">
                {email?.split('@')[0] || 'Unknown'}
              </p>
              <p className="text-xs text-gray-600">via {channel}</p>
              <a href={`mailto:${email}`} className="text-xs text-gray-500">
                {email || phone}
              </a>
            </div>
          </div>
          <p className="text-xs font-medium text-gray-600 flex items-center">
            {created_at || 'Unknown date'}
            <StarIcon className="w-4 h-4 text-yellow-400 ml-2" />
          </p>
        </div>

        <div className="mb-5">
          <h6 className="mb-2 font-semibold text-gray-900 text-sm dark:text-white">{subject}</h6>
          <p className="text-gray-500 text-xs">{description}</p>
          {attachments.length > 0 && <AttachmentList attachments={attachments} />}
        </div>

        <div className="relative my-8 text-center">
          <hr className="border-gray-300" />
          <span className="absolute inset-x-0 -top-3 bg-white px-4 text-sm text-gray-600 dark:bg-zinc-900">
            <button className="border px-4 py-1 text-white rounded-full bg-violet-500">
              Conversations <span className="px-1 bg-white text-violet-500 rounded-full">{replies.length}</span>
            </button>
          </span>
        </div>

        {replies.map((reply, index) => (
          <ReplyCard
            key={index}
            subject={subject}
            reply_message={reply.reply_message}
            reply_at={reply.reply_at}
            user={reply.user}
            email={reply.email}
          />
        ))}

        <div className="flex justify-end gap-2 mt-6">
          <button
            onClick={() => setShowReplyForm(!showReplyForm)}
            className="flex items-center gap-1 text-sm border px-3 py-1 text-white bg-violet-500 rounded hover:bg-violet-600"
            disabled={isSubmitting}
          >
            {isSubmitting ? <div className="flex justify-center items-center">
              <svg className="animate-spin h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8z"></path>
              </svg>
            </div> : <PaperAirplaneIcon className="w-4 h-4" />}
            {showReplyForm ? 'Cancel' : 'Reply'}
          </button>
          <button className="flex items-center gap-1 text-sm border px-3 py-1 text-white bg-green-500 rounded hover:bg-green-600">
            <ArrowRightCircleIcon className="w-4 h-4" />
            Assign User
          </button>
          <button className="flex items-center gap-1 text-sm border px-3 py-1 text-white bg-red-500 rounded hover:bg-red-600">
            <LockClosedIcon className="w-4 h-4" />
            Close Ticket
          </button>
        </div>

        {showReplyForm && <ReplyForm onSubmit={handleReplySubmit} isSubmitting={isSubmitting} />}
      </div>

      <div className="bg-gray-100 px-4 py-2 border-t flex justify-end gap-2">
        <button className="text-gray-600 hover:text-gray-800">
          <EllipsisVerticalIcon className="w-5 h-5" />
        </button>
        <button className="text-red-600 hover:text-red-800">
          <TrashIcon className="w-5 h-5" />
        </button>
      </div>

      <div className="p-4 m-4 dark:bg-zinc-900">
        <div className="bg-gray-100 px-4 py-3 mb-2">
          <h5 className="flex items-center gap-2 text-lg font-medium text-gray-800">
            <CalendarDaysIcon className="w-5 h-5" />
            <span>Events</span>
          </h5>
        </div>
        {events.map((event, index) => (
          <EventCard
            key={event.id || index}
            created_at={event.created_at}
            due_date={event.due_date}
            event_type={event.event_type}
            status={event.status}
            policy={event.policy}
          />
        ))}
      </div>
    </div>
  );
};

export default TicketDetail;
