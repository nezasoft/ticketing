export interface Ticket{
    id: number;
    ticket_no: string;
    customer_id: number;
    priority_id: number;
    channel_id: number;
    customer_type : number;
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
    name?:string;
    events?: any[];
    replies?: any[];
    attachments?: Attachment[];
    thread_attachments?: Attachment[];
    
}

export interface Setting
{
    priorities?: any[];
    roles?: any[];
    notification_types?: any[];
    ticket_status?: any[];
    channels?: any[];
    departments?: any[];
    country_codes?: any[];
    customer_types?: any[];
    sla_policies?: any[];
    customers?: any[];
    users?: any[];
    emails?: any[];
    event_types? : any[];
    integrations? : any[];
    template_types? : any[];

}

export interface AuthUser{
    id: number;
    name:string;
    active:string;
    email: string;
    company_id: number;
    phone?: string;
    dept_id: string;
    role_id: string;
    status: string;
    created_at?: string;
    updated_at?: string;
    date_created?: string;
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
  attachments?: Attachment[];

}
export interface EventType {
    id: number;
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
    thread_id:number;
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
    id: number;
    name?: string;
    email?: string;
    phone?: string;
    client_no?:string;
    company_id?: number;
    account_no?: string;
}

export interface CustomerType
{
    id: number;
    name: string;
    company_id: number;
}

export interface Department
{
    id: number;
    name: string;
    company_id: number;
}

export interface DepartmentHead
{
    id: number;
    user_id: number;
    dept_id: number;   
}

export interface Email
{
    id: number,
    email: string;
    name: string;
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
export interface Integration
{
    id: number,
    code: string;
    value: string;
    company_id: number;
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
    remarks:string;
}
export interface TicketResolve
{
    ticket_id: number;
    user_id: number;
    remarks:string;
}
export interface TicketClose
{
    ticket_id: number;
    user_id: number;
    remarks:string;
}
export interface Template
{
    id: number;
    name: string;
    subject: string;
    message: string;
    type_id: number;
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
    newTicket: (payload: FormData) => Promise<GenericResponse<Ticket | null>>;
    deleteTicket: (ticket_id: number) => Promise<GenericResponse<null>>;
    replyTicket: (payload:FormData) => Promise<GenericResponse<Reply | null>>;
    resolveTicket: (payload:FormData) => Promise<GenericResponse<TicketResolve | null>>;
    closeTicket: (payload:FormData) => Promise<GenericResponse<TicketClose | null>>;
    loading: boolean;
}

export interface SettingContextType
{
    setting: Setting | null;
    user: AuthUser | null;
    dept: Department | null;
    email: Email | null;
    eventType: EventType | null;
    integration: Integration | null;
    template: Template | null;
    listSettings: (company_id: number) => Promise<GenericResponse<Setting | null>>;
    //Users Menu
    newUser: (payload: FormData) => Promise<GenericResponse<AuthUser | null>>;
    viewUser: (user_id: number) => Promise<GenericResponse<AuthUser | null>>;
    editUser: (payload:FormData) => Promise<GenericResponse<AuthUser | null>>;
    deleteUser: (user_id: number) => Promise<GenericResponse<null>>;
    //Departments Menu
    newDepartment: (payload: FormData) => Promise<GenericResponse<Department | null>>;
    editDepartment: (payload: FormData) => Promise<GenericResponse<Department | null>>;
    deleteDepartment: (dept_id: number) => Promise<GenericResponse<null>>;

    //Emails Menu
    newEmail: (payload: FormData) => Promise<GenericResponse<Email | null>>;
    editEmail: (payload: FormData) => Promise<GenericResponse<Email |  null>>;
    deleteEmail: (email_id: number) => Promise<GenericResponse<null>>;
    //Integration Menu
    newIntegration: (payload: FormData) => Promise<GenericResponse<Integration | null>>;
    editIntegration: (payload: FormData) => Promise<GenericResponse<Integration | null>>;
    deleteIntegration: (integration_id: number) => Promise<GenericResponse<null>>;
    //Templates Menu
    newTemplate: (payload: FormData) => Promise<GenericResponse<Template | null>>;
    editTemplate: (payload: FormData) => Promise<GenericResponse<Template  | null>>;
    deleteTemplate: (template_id: number) => Promise<GenericResponse<Template | null>>;
    
    loading: boolean;
}

export interface TicketAssignmentContextType
{
    ticket_assignment : TicketAssignment | null;
    listTicketAssignments: (company_id: number) => Promise<GenericResponse<TicketAssignment[]>>;
    editTicketAssignment: (ticket_assignment_id: number, data: Partial<TicketAssignment>) => Promise<GenericResponse<TicketAssignment | null>>;
    newTicketAssignment: (payload: FormData) => Promise<GenericResponse<TicketAssignment | null>>;
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



