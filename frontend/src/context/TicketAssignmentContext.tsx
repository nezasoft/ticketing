import React, {createContext, useState, useCallback, useMemo, ReactNode} from "react";
import { TicketAssignmentContextType, TicketAssignment, GenericResponse } from "../types";
import { getTicketAssignments, editTicketAssignment, newTicketAssignment } from "../service/ticketAssignmentService";

const defaultContext: TicketAssignmentContextType = {
    ticket_assignment: null,
    loading: false,
    listTicketAssignments: async () => ({success: false, message:'', data:[]}),
    editTicketAssignment: async () => ({success: false, message:'',data:null}),
    newTicketAssignment: async () => ({success: false, message:'', data: null})
};

export const TicketAssignmentContext = createContext<TicketAssignmentContextType>(defaultContext);

type Props = {
    children: ReactNode;
};

export const TicketAssignmentProvider: React.FC<Props> = ({children}) => {
    const [ticket_assignment] = useState<TicketAssignment | null>(null);
    const [loading, setLoading] = useState<boolean>(false);

    const fetchTicketAssignments = useCallback(async (company_id: number): Promise<GenericResponse<TicketAssignment[]>> =>{
        setLoading(true);
        try{
            const response = await getTicketAssignments(company_id);
            return response;
        }catch(error)
        {
            console.error('Error fetching Ticket Assignments',error);
            return {success: false, message: 'Error fetching ticket assignments',data: []};
        }finally{
            setLoading(false);
        }
    },[]);

    const handleEditTicketAssignment = useCallback(async (
        ticket_assignment_id: number,
        data: Partial<TicketAssignment>
    ):Promise<GenericResponse<TicketAssignment | null>> => {
        return editTicketAssignment(ticket_assignment_id, data)
    },[]);

    const handleNewTicketAssignment = useCallback(async (
        payload: FormData
    ): Promise<GenericResponse<TicketAssignment | null>> =>
    {
        return newTicketAssignment(payload);
    },[]);

    const contextValue = useMemo(()=>({
        ticket_assignment,
        loading,
        listTicketAssignments: fetchTicketAssignments,
        newTicketAssignment: handleNewTicketAssignment,
        editTicketAssignment: handleEditTicketAssignment

    }),[
        ticket_assignment,
        loading,
        fetchTicketAssignments,
        handleNewTicketAssignment,
        handleEditTicketAssignment
    ]);

    return (
        <TicketAssignmentContext.Provider value={contextValue}>
            {children}
        </TicketAssignmentContext.Provider>
    )
};