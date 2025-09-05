import { Fragment } from "react";
import { Dialog, Transition } from "@headlessui/react";
import DOMPurify from 'dompurify';
type Template =  {
    id: number;
    name: string;
    subject: string;
    message: string;
    type_id: number;
};

type ViewTemplateModalProps = {
  isOpen: boolean;
  onClose: () => void;
  template: Template;
};

const ViewTemplateModal: React.FC<ViewTemplateModalProps> = ({ isOpen, onClose,template }) => {
  return (
    <Transition.Root show={isOpen} as={Fragment}>
      <Dialog as="div" className="relative z-50" onClose={() => {}}>
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
                    View Email Template
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
                    <span className="font-semibold">Name:</span> {template.name}
                  </div>
                  <div>
                    <span className="font-semibold">Subject:</span> {template.subject}
                  </div>
                  <div>
                    <p className="text-gray-500 text-xs" dangerouslySetInnerHTML={{ __html: DOMPurify.sanitize(template.message) }}></p>
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

export default ViewTemplateModal;
