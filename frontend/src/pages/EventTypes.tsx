import React, {useEffect, useState, useContext, useCallback} from 'react';
import { EventType } from '../types';
import Sidebar from '../components/common/Sidebar';
import Navbar from '../components/common/Navbar';
import { SettingContext } from '../context/SettingContext';
import { ArrowPathIcon } from '@heroicons/react/24/solid';
import EventTypesList from '../components/event_types/EventTypesList';


const EventTypes: React.FC = () =>
{
    const [eventTypes, setEventTypes] = useState<EventType[]>([]);
    const [loading, setLoading] = useState<boolean>(true);
    const settingCtx = useContext(SettingContext);


    const fetchEventTypes = useCallback(async ()=>
    {
        try
        {

            const userString = localStorage.getItem('user');
            if(!userString)
            {
                console.warn('User not found in localStorage');
                return;
            }
            const user = JSON.parse(userString);
            const companyId = user.company_id;
            if(!user.company_id)
            {
                console.warn("User company id missing.");
                return;
            }
            if(settingCtx?.listSettings)
            {
                const response = await settingCtx.listSettings(companyId);
                if(response.success && response.data?.event_types)
                {
                    setEventTypes(response.data.event_types);
                }else{
                    console.log('Failed to fetch event types:',response.message);
                }
            }
        }catch(error)
        {
            console.error('Error fetching event types');
        }finally{
            setLoading(false);
        }
    },[settingCtx]);

    useEffect(()=>
    {
        fetchEventTypes();
    },[fetchEventTypes]);

    if(loading)
    {
        return (
        <div className="flex flex-col items-center justify-center h-screen bg-white dark:bg-zinc-900 text-gray-800 dark:text-white">
            <ArrowPathIcon className="h-10 w-10 animate-spin text-violet-600 mb-4" />
            <p className="text-lg font-medium">Loading...</p>        
        </div>
        );

    }

    return (
        <div className="flex dark:bg-zinc-900 text-gray-800 dark:text-white">
            <Navbar />
            <Sidebar />
            <main className="md:ml-[250px] md:mt-[70px] ml-0 p-4 w-full h-full">
                <div className="flex flex-wrap items-center justify-between mb-4">
                    <h2 className="text-xl font-semibold">Event Types</h2>
                    <div className="flex flex-wrap gap-2 items-center">
            
                    </div>
                </div>
                <EventTypesList eventTypes={eventTypes} onUpdated={fetchEventTypes} />

            </main>
        </div>
    );

};

export default EventTypes;