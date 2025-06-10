export interface Ticket{
    id: number;
    ticket_no: string;
    customer_id: number;
    priority_id: number;
    channel_id: number;
    ticket_type_id : number;
    subject?: string;
    status_id: number;
    company_id: number;
    dept_id: number;
    description?: string;
    first_response_at?: string;
    resolved_at?: string;
    created_at?:string;
    updated_at?:string;
    sla_policy_id:number;
    sla_duration:number;
    escalated_at?: string;
    phone?:string;
    email?:string;
    
}

export interface AuthUser{
    id: number;
    email: string;
    company_id: number;
    phone?: string;
    dept_id: number;
    status: number;
    created_at?: string;
    updated_at?: string;
}

export interface BusinessDoc{
    id: number;
    company_id: number;
    document_name?: string;
    document_no:BigInteger;
    document_value:BigInteger;
    doc_code?: string;
    udpated_at?: string;
    created_at?: string;

}

export interface channel_id{
    id: number;
    name?:string;
}

export interface ChannelContact
{
    id:number;
    email?:string;
    phone?:string;
    company_id:number;
}

export interface company_id{
    id: number;
    name?: string;
    website?:string;
    email?:string;
    phy_add?:string;
    phone?: string;
    client_no?: string;
    company_logo?: string;
    active: number;
    days: number;
}

export interface AuthContextType
{
    user: AuthUser | null;
    token: string | null;
    login: (email: string,password: string) => Promise<void>;
    logout: () => void;
}

export interface ApiResponse<T>
{
    data: T;
    message: string;
}


