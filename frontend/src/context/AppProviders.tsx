import React from 'react';
import { AuthProvider } from './AuthContext';
import { SettingProvider } from './SettingContext';
import { TicketProvider } from './TicketContext';
import { TicketAssignmentProvider } from './TicketAssignmentContext';
import { TemplateProvider } from './TemplateContext';

interface Props {
  children: React.ReactNode;
}

const AppProviders: React.FC<Props> = ({ children }) => {
  return (
    <AuthProvider>
      <SettingProvider>
        <TemplateProvider>
          <TicketProvider>
          <TicketAssignmentProvider>
            {children}
          </TicketAssignmentProvider>       
        </TicketProvider>
        </TemplateProvider>
        
      </SettingProvider>
    </AuthProvider>
  );
};

export default AppProviders;
