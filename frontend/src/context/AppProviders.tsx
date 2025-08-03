import React from 'react';
import { AuthProvider } from './AuthContext';
import { SettingProvider } from './SettingContext';
import { TicketProvider } from './TicketContext';
import { TicketAssignmentProvider } from './TicketAssignmentContext';

interface Props {
  children: React.ReactNode;
}

const AppProviders: React.FC<Props> = ({ children }) => {
  return (
    <AuthProvider>
      <SettingProvider>
        <TicketProvider>
          <TicketAssignmentProvider>
            {children}
          </TicketAssignmentProvider>       
        </TicketProvider>
      </SettingProvider>
    </AuthProvider>
  );
};

export default AppProviders;
