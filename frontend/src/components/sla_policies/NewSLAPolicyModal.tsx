import React, {Fragment, useState, useContext, useEffect} from 'react';
import {Dialog, Transition} from '@headlessui/react';
import { SLAContext } from '../../context/SLAContext';
import { SLAPolicy } from '../../types';
import { toast } from 'react-toastify';

interface Props
{
    isOpen: boolean;
    onClose: () => void;
    onCreated: () => void;
}
const NewSLAPolicyModal: React.FC<Props> = ({isOpen, onClose, onCreated}) =>{
    const {newSLAPolicy} = useContext(SLAContext);
    const [form, setForm] = useState<Partial<SLAPolicy>>({
            name: "",
            response_time_min: undefined,
            resolve_time_min: undefined
    });
    const [submitting, setSubmitting]= useState(false);
    const [error, setError] = useState<string | null>(null);
    useEffect(()=>{
        if(!isOpen)
        {
            setForm({
                name: "",
                response_time_min: undefined,
                resolve_time_min: undefined
            });
            setError(null);
        }
    },[isOpen]);
    const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
        setForm((prev)=> ({...prev, [e.target.name]: e.target.value}));
    };
    const handleSubmit = async (e: React.FormEvent) => 
    {
        e.preventDefault();
        setSubmitting(true);
        setError(null);
        try
        {
            const user = JSON.parse(localStorage.getItem('user')!);
            const formData = new FormData();
            formData.append('company_id',user.company_id);
            formData.append('user_id',user.id);
            Object.entries(form).forEach(([keyboard, value])=>{
                if(value !== undefined && value !==null)
                {
                    formData.append(keyboard, value as string);
                }
            });
            const response = await newSLAPolicy(formData);
            if(response.success)
            {
                toast.success('Record created successfully');
                onCreated();
                onClose();              
            }else{
                const message = typeof response.message === 'string' 
                ? response.message
                 : Object.values(response.message || {}).join(',');
                 toast.error(message || 'Failed to create a new record');
            }

        }catch(err: any)
        {
            toast.error(err.message || 'Unexpected error occured');
        }finally{
            setSubmitting(false);
        }
    }
    return(
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
                    <div className="fixed inset-0 bg-gray-600 bg-opacity-30 transition-opacity"/>
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
                                <div className="flex justify-between items-center">
                                    <Dialog.Title className="text-lg font-medium text-gray-800 dark:text-white text-left">
                                        Create SLA Policy
                                    </Dialog.Title>
                                    <button 
                                    onClick={onClose} 
                                    type="button"
                                    className="text-gray-500 hover:text-gray-700 dark:hover:text-white text-xl font-bold"
                                     >&times;</button>
                                </div>
                                {error && <div className="text-red-600 text-sm">{error}</div>}
                                <form onSubmit={handleSubmit} className="space-y-4">
                                    <label className="block text-sm font-medium text-left">
                                    Name
                                    </label>
                                    <input
                                        autoComplete="off"
                                        name="name"
                                        value={form.name || ""}
                                        onChange={handleChange}
                                        required
                                        className="mt-1 block w-full border border-gray-200 rounded p-2 bg-gray-50 dark:bg-zinc-700"
                                    />

                                    <label className="block text-sm font-medium text-left">
                                        Response Time (Minutes)
                                    </label>
                                    <input
                                        autoComplete="off"
                                        name="response_time_min"
                                        value={form.response_time_min || ""}
                                        onChange={handleChange}
                                        required
                                        className="mt-1 block w-full border border-gray-200 rounded p-2 bg-gray-50 dark:bg-zinc-700"
                                    />
                                    <label className="block text-sm font-medium text-left">
                                        Resolve Time (Minutes)
                                    </label>
                                    <input
                                        autoComplete="off"
                                        name="resolve_time_min"
                                        value={form.resolve_time_min || ""}
                                        onChange={handleChange}
                                        required
                                        className="mt-1 block w-full border border-gray-200 rounded p-2 bg-gray-50 dark:bg-zinc-700"
                                    />
                                    <div className="flex justify-end space-x-2 mt-4">
                                        <button
                                        type="button"
                                        onClick={onClose}
                                        className="px-4 py-2 text-white rounded bg-gray-600 dark:bg-red-600"
                                        disabled={submitting}
                                        >
                                        Cancel
                                        </button>
                                        <button
                                        type="submit"
                                        className="px-4 py-2 rounded bg-violet-600 text-white"
                                        disabled={submitting}
                                        >
                                        {submitting ? "Saving..." : "Save Changes"}
                                        </button>
                                    </div>
                                    </form>
                            </Dialog.Panel>
                        </Transition.Child>
                    </div>
                </div>
            </Dialog>
        </Transition.Root>
    );
    
};

export default NewSLAPolicyModal;