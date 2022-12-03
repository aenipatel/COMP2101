get-ciminstance win32_networkadapterconfiguration | 
Where IPEnabled -eq True |
format-table -autosize Description, Index, IPAddress, IPSubnet, DNSDomain, DNSServerSearchOrder