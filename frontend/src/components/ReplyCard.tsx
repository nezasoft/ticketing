import React from 'react';
import { UserCircleIcon } from '@heroicons/react/24/solid';
import { Attachment } from '../types';
import AttachmentList from './AttachmentList';
import DOMPurify from 'dompurify';
interface ReplyCardProps {
  thread_id: number;
  reply_message: string;
  reply_at: string;
  user: string;
  email: string;
  subject?: string;
  attachments?: Attachment[];
}

const ReplyCard: React.FC<ReplyCardProps> = ({ reply_message, reply_at, user, email, subject,attachments = [] }) => (
  <div className="mb-4 p-2">
    <div className="flex items-center gap-3 mb-2">
      <UserCircleIcon className="w-10 h-10 text-gray-400" />
      <div>
        <p className="font-semibold">{user}</p>
        <a href={`mailto:${email}`} className="text-xs text-gray-500">{email}</a>
      </div>
    </div>
    <p className="text-xs text-gray-600">{reply_at}</p>
    <h6 className="text-sm font-semibold mt-2">{subject}</h6>
    <p className="text-xs text-gray-500 whitespace-pre-line" dangerouslySetInnerHTML={{ __html: DOMPurify.sanitize(reply_message) }}></p>
    {attachments.length > 0 && (
        <div className="mt-2">
          <AttachmentList attachments={attachments} />
        </div>
      )}
  </div>
);

export default ReplyCard;
