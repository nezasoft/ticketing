import React from 'react';
import { ArrowDownTrayIcon, DocumentIcon, PaperClipIcon } from '@heroicons/react/24/solid';
import { Attachment } from '../../types';

const AttachmentList: React.FC<{ attachments: Attachment[] }> = ({ attachments }) => (
  <div className="mt-4 bg-gray-50 p-4 rounded-md">
    <div className="space-y-2">
      {attachments.map((file, idx) => (
        <div key={idx} className="flex items-center text-sm bg-white border rounded p-2">
          <DocumentIcon className="w-5 h-5 text-gray-600" />
          <span className="ml-2 flex-1">{file.file_name}</span>
          {file.file_path && (
            <a href={file.file_path} download className="text-gray-400 hover:text-gray-600">
              <ArrowDownTrayIcon className="w-5 h-5" />
            </a>
          )}
        </div>
      ))}
    </div>
    <div className="flex justify-between items-center mt-4 text-sm">
      <p className="flex items-center text-gray-700">
        <PaperClipIcon className="w-4 h-4 mr-1" />
        {attachments.length} file{attachments.length !== 1 ? 's' : ''} attached
      </p>
    </div>
  </div>
);

export default AttachmentList;
