root_name_read = './1e2456Events/1e2456Event_';

extension = '.out';
root_name_write = './1e2456EventsElec/1e2456EventElec_';

for i = 1:4
    
    % open the relevant files 
    curr_name_read = [root_name_read num2str(i) extension];   % don't touch
    
    curr_name_write = [root_name_write num2str(i) extension];
    
    % write the top file with flipped xyz (maybe xyz correlated) into output file
    curr_in_fid = fopen(curr_name_read,'r');
    curr_out_fid = fopen(curr_name_write,'w');
    
    in_line = fgetl(curr_in_fid);
    while ischar(in_line)
        in_lineCell = split(in_line);
        
        in_dE = str2num(in_lineCell{5,1}) * 1000; % 1000 converts MeV2keV
        
        [n,yields] = dE2electrons(in_dE);
        
        out_lineCell = in_lineCell;

        out_lineCell{5,1} = num2str(n);
        
        fprintf(curr_out_fid,'%s\t%s\t%s\t%s\t%s\t%s\n',out_lineCell{:});
        in_line = fgetl(curr_in_fid);
    end
    
    fclose(curr_in_fid);
    fclose(curr_out_fid);
    

    if mod(i,1) == 0
        disp(num2str(i));
    end
    
end

