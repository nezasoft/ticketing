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
    user_id: number;
    description: string;
    first_response_at?: string;
    resolved_at?: string;
    created_at?:string;
    updated_at?:string;
    sla_policy_id:number;
    sla_duration:number;
    escalated_at?: string;
    phone?: string;
    email?: string;
    priority: string;
    status: string;
    channel: string;
    dept: string;
    company: string;
    events?: any[];
    replies?: any[];
    attachments?: Attachment[];
    
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

export interface Channel
{
    id: number;
    name?:string;
}
export interface Reply {
  user_id: number;
  ticket_id: number;
  reply_message: string;
  attachments?: File[];
}
export interface EventType {
  name: string;
}
export interface SLAEvent
{
    ticket_id : number;
    event_type_id: number;
    status_id: number;
    due_date: string;
    company_id : number;
    met_at: string;
    sla_policy_id : number;
}

export interface Attachment
{
    ticket_id: number;
    user_id: number;
    file_name?: string;
    file_path?: string;
}


export interface ChannelContact
{
    id:number;
    email?:string;
    phone?:string;
    company_id:number;
}

export interface Company
{
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

export interface Customer 
{
    name?: string;
    email?: string;
    phone?: string;
    client_no?:string;
    company_id?: number;
    account_no?: string;
}

export interface CustomerType
{
    name: string;
    company_id: number;
}

export interface Department
{
    name: string;
    company_id: number;
}

export interface DepartmentHead
{
    user_id: number;
    dept_id: number;   
}

export interface Email
{
    email: string;
    name: string;
    dept_id: number;
    priority_id: number;
    company_id: number;
    username: string;
    password: string;
    fetching_host: string;
    fetching_post: string;
    fetching_protocol: string;
    fetching_encryption: string;
    active: number;
}
export interface Notification
{
    user_id: number;
    type_id : number;
    company_id: number;
    status: number;
}
export interface NotificationType
{
    message:string;
    type:string;   
}
export interface SLAPolicy{
    name:string;
    response_time_min:number;
    resolve_time_min:number;
    company_id: number;
    is_default:number;
}

export interface SLARule
{
    sla_policy_id:number;
    customer_type_id:number;
    priority_id:number;
    channel_id:number;
    company_id:number;
}

export interface TicketAssignment
{
    ticket_id:number;
    user_id:number;
}
export interface AuthContextType {
    user: AuthUser | null;
    token: string | null;
    login: (email: string, password: string) => Promise<GenericResponse<{ user: AuthUser; token: string }>>;
    logout: () => void;
    register: (email: string, password: string, phone: string, name: string) => Promise<GenericResponse<any>>;
    recover: (email: string) => Promise<GenericResponse<any>>;
    loading: boolean;
}
export interface TicketContextType {
    ticket: Ticket | null;
    listTickets: (company_id: number) => Promise<GenericResponse<Ticket[]>>;
    editTicket: (ticket_id: number,data: Partial<Ticket>) => Promise<GenericResponse<Ticket | null>>;
    viewTicket: (ticket_id: number) => Promise<GenericResponse<Ticket | null>>;
    newTicket: (payload: Partial<Ticket> & {company_id: number, user_id?: number}) => Promise<GenericResponse<Ticket | null>>;
    deleteTicket: (ticket_id: number) => Promise<GenericResponse<null>>;
    replyTicket: (payload:FormData) => Promise<GenericResponse<Reply | null>>;
    loading: boolean;
}


export interface ApiResponse<T>
{
    data: T;
    message: string;
}

export interface LoginResponse {
    success: boolean;
    message: string;
    data: AuthUser;
    token: string;
}

export interface GenericResponse<T>
{
    success: boolean;
    message: string;
    data: T;
}



