import { Fragment } from "react";
import { Dialog, Transition } from "@headlessui/react";

type Email =  {
    id: number;
    name: string;
    email: string;
    dept_id: number;
    priority_id: number;
    company_id: number;
    username: string;
    password: string;
    host: string;
    incoming_port: string;
    outgoing_port: string;
    protocol: string;
    encryption: string;
    folder: string;
    active: string;
};

type ViewEmailModalProps = {
  isOpen: boolean;
  onClose: () => void;
  email: Email;
};

const ViewEmailModal: React.FC<ViewEmailModalProps> = ({ isOpen, onClose, email }) => {
  return (
    <Transition.Root show={isOpen} as={Fragment}>
      <Dialog as="div" className="relative z-50" onClose={onClose} >
        <Transition.Child
          as={Fragment}
          enter="ease-out duration-300"
          enterFrom="opacity-0"
          enterTo="opacity-100"
          leave="ease-in duration-200"
          leaveFrom="opacity-100"
          leaveTo="opacity-0"
        >
          <div className="fixed inset-0 bg-gray-600 bg-opacity-30 transition-opacity" />
        </Transition.Child>

        <div className="fixed inset-0 z-50 overflow-y-auto dark:bg-zinc-900 text-gray-800 dark:text-white">
          <div className="flex min-h-full items-center justify-center p-4 text-center">
            <Transition.Child
              as={Fragment}
              enter="ease-out duration-300"
              enterFrom="opacity-0 scale-95"
              enterTo="opacity-100 scale-100"
              leave="ease-in duration-200"
              leaveFrom="opacity-100 scale-100"
              leaveTo="opacity-0 scale-95"
            >
              <Dialog.Panel className="bg-white dark:bg-zinc-800 rounded-lg w-full max-w-2xl p-6 space-y-4 shadow-xl border border-gray-300">
                {/* Header */}
                <div className="flex justify-between items-center">
                  <Dialog.Title className="text-lg font-medium text-gray-800 dark:text-white text-left">
                    View Email Account
                  </Dialog.Title>
                  <button
                    onClick={onClose}
                    type="button"
                    className="text-gray-500 hover:text-gray-700 dark:hover:text-white text-xl font-bold"
                  >
                    &times;
                  </button>
                </div>

                {/* Details */}
                <div className="space-y-3 text-left">
                  <div>
                    <span className="font-semibold">Account Name:</span> {email.name}
                  </div>
                  <div>
                    <span className="font-semibold">Email:</span> {email.email}
                  </div>
                  <div>
                    <span className="font-semibold">Username:</span> {email.username}
                  </div>
                  <div>
                    <span className="font-semibold">Host:</span> {email.host}
                  </div>
                  <div>
                    <span className="font-semibold">Incoming Port:</span> {email.incoming_port}
                  </div>
                  <div>
                    <span className="font-semibold">Outgoing Port:</span> {email.outgoing_port}
                  </div>
                  <div>
                    <span className="font-semibold">Protocol:</span> {email.protocol}
                  </div>
                  <div>
                    <span className="font-semibold">Encryption:</span> {email.encryption}
                  </div>
                  <div>
                    <span className="font-semibold">Inbox Folder:</span> {email.folder}
                  </div>
                  <div>
                    <span className="font-semibold">Status:</span>{" "}
                    {email.active === "1" ? "Active" : "Inactive"}
                  </div>
                </div>

                {/* Footer */}
                <div className="flex justify-end mt-4">
                  <button
                    type="button"
                    onClick={onClose}
                    className="px-4 py-2 text-white rounded bg-gray-600 dark:bg-red-600"
                  >
                    Close
                  </button>
                </div>
              </Dialog.Panel>
            </Transition.Child>
          </div>
        </div>
      </Dialog>
    </Transition.Root>
  );
};

export default ViewEmailModal;
