% Read

function data = readCSV(fname)

  data = [];

  fid = fopen(fname);

  while (! feof(fid) )
    line = fgets(fid);
    raw_data = strsplit(line, ',', "collapsedelimiters", false);

    line_data = [];

    for i = 2:size(raw_data)(2)
      line_data = [line_data, str2num(raw_data{i})];
    end

    data = [data; line_data];
  end


end
