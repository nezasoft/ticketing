import React from 'react';
import { AuthProvider } from './AuthContext';
import { SettingProvider } from './SettingContext';
import { TicketProvider } from './TicketContext';
import { TicketAssignmentProvider } from './TicketAssignmentContext';
import { TemplateProvider } from './TemplateContext';
import { SLAProvider } from './SLAContext';
import { CustomerProvider } from './CustomerContext';

interface Props {
  children: React.ReactNode;
}

const AppProviders: React.FC<Props> = ({ children }) => {
  return (
    <AuthProvider>
      <SettingProvider>
        <TemplateProvider>
        <CustomerProvider>
          <TicketProvider>
            <SLAProvider>
            <TicketAssignmentProvider>
              {children}
            </TicketAssignmentProvider> 
          </SLAProvider>      
        </TicketProvider>
        </CustomerProvider>
        </TemplateProvider>
        
      </SettingProvider>
    </AuthProvider>
  );
};

export default AppProviders;
