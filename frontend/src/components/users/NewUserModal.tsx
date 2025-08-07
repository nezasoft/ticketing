import React, {Fragment, useState, useContext, useEffect} from 'react';
import {Dialog, Transition} from '@headlessui/react';
import { SettingContext } from '../../context/SettingContext';
import { AuthUser } from '../../types';
import { keyboard } from '@testing-library/user-event/dist/keyboard';
import { toast } from 'react-toastify';
interface Props
{
    isOpen: boolean;
    onClose: () => void;
    onCreated: () => void;
}


const NewUserModal: React.FC<Props> = ({isOpen, onClose, onCreated}) =>{
    const {newUser} = useContext(SettingContext);
    const [form, setForm] = useState<Partial<AuthUser>>({
        name: '',
        email: '',
        phone:'',
        department:undefined,
        role:undefined,
    });

    const [submitting, setSubmitting]= useState(false);
    const [error, setError] = useState<string | null>(null);

    useEffect(()=>{
        if(!isOpen)
        {
            setForm({
                name :'',
                email: '',
                phone:'',
                department: undefined,
                role: undefined
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

            const response = await newUser(formData);
            if(response.success)
            {
                toast.success('User account created successfully');
                onCreated();
                onClose();

                
            }else{
                const message = typeof response.message === 'string' 
                ? response.message
                 : Object.values(response.message || {}).join(',');
                 toast.error(message || 'Failed to create a new user account');
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
            <Dialog as="div" className="relative z-50" onClose={()=> {}}>
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

                            </Dialog.Panel>

                        </Transition.Child>

                    </div>
                </div>
            </Dialog>
        </Transition.Root>

    );

    
}