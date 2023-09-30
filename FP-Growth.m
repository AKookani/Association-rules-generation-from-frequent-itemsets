clc

a = unique(ID_Order);

table1 = zeros(length(a), 4);
table1_temp = cell(length(a), 1);

disp("dataset is transforming to table1")

for i = 1:length(a)
    row = find(ID_Order == a(i));
    temp = zeros(1, length(row));
    for j = 1:length(row)
       temp(1, j) = ID_Item(row(j));
    end
    table1(i, 1:length(row)) = sort(temp);
    table1_temp{i, 1} = sort(temp);
end
table1 = sortrows(table1);

disp("1item sets are getting ready in table2")
b = unique(ID_Item);
table2 = zeros(length(b), 2);

for i = 1:length(b)
    row = find(table1 == b(i));
    table2(i, 1) = b(i);
    table2(i, 2) = length(row);
end

minsup = input('Enter the desired minimum support: ');
disp("1item set's support percents are getting ready in table3")

i1 = 0;
row = find(table2(:, 2)>minsup);
table3 = zeros(length(row), 3);
for i = 1:length(table2)
   if table2(i, 2) >= minsup
       i1 = i1 + 1;
       table3(i1, 1:2) = table2(i, 1:2);
       table3(i1, 3) = (table3(i1,2)/ length(row)) * 100;
   end
end


disp("2item sets are getting ready in table4")
table4 = zeros(2275, 2);
k = 1;
for i = 1:length(table1_temp)
   if length(table1_temp{i})==2
      table4(k, 1:2) = table1_temp{i};
      k = k + 1;
   elseif length(table1_temp{i})==3
      table4(k, 1:2) = table1_temp{i}(1, [1 2]);
      k = k + 1;
      table4(k, 1:2) = table1_temp{i}(1, [1 3]);
      k = k + 1;
      table4(k, 1:2) = table1_temp{i}(1, [2 3]);
      k = k + 1;
   elseif length(table1_temp{i})==4
      table4(k, 1:2) = table1_temp{i}(1, [1 2]);
      k = k + 1;
      table4(k, 1:2) = table1_temp{i}(1, [1 3]);
      k = k + 1;
      table4(k, 1:2) = table1_temp{i}(1, [2 3]);
      k = k + 1;
      table4(k, 1:2) = table1_temp{i}(1, [1 4]);
      k = k + 1;
      table4(k, 1:2) = table1_temp{i}(1, [3 4]);
      k = k + 1;
      table4(k, 1:2) = table1_temp{i}(1, [2 4]);
      k = k + 1;
   end
end
table4 = sortrows(table4);


table5 = zeros(2422, 6);
k = 1;
for i = 1:length(table1_temp)
    for j = 1:length(table4)
        x = 0;
        if length(table1_temp{i}) == 2
            x = x + isequal(table1_temp{i}, table4(j, :));
        elseif length(table1_temp{i})  == 3
            x = x + isequal(table1_temp{i}(1, [1 2]), table4(j, :));
            x = x + isequal(table1_temp{i}(1, [1 3]), table4(j, :));
            x = x + isequal(table1_temp{i}(1, [2 3]), table4(j, :));
        elseif length(table1_temp{i})  == 4
            x = x + isequal(table1_temp{i}(1, [1 2]), table4(j, :));
            x = x + isequal(table1_temp{i}(1, [1 3]), table4(j, :));
            x = x + isequal(table1_temp{i}(1, [2 3]), table4(j, :));
            x = x + isequal(table1_temp{i}(1, [1 4]), table4(j, :));
            x = x + isequal(table1_temp{i}(1, [2 4]), table4(j, :));
            x = x + isequal(table1_temp{i}(1, [3 4]), table4(j, :));
        end
        if x >= minsup
            table5(k, 1:2) = table4(j, :);
            table5(k, 3) = x;
            row1 = find(table1 == table5(k, 1));
            row2 = find(table1 == table5(k, 2));
            table5(k, 4) = (x / length(table1)) / ((length(row2) / length(table1)) * (length(row1) / length(table1)));
            table5(k, 5) = ((x - ((length(row2) * length(row1)) / length(table1))) ^ 2)/ ((length(row2) * length(row1)) / length(table1)) + ((((length(table1)-length(row1)-length(row2)+x) - ((length(table1)-length(row2)) * (length(table1)-length(row1))) / length(table1)) ^ 2)/ ((length(table1)-length(row2)) * (length(table1)-length(row1))) / length(table1)) + ((((length(row1)-x)-((length(table1)-length(row2))*length(row1))/length(table1))^2)/((length(table1)-length(row2))*length(row1))/length(table1)) + ((((length(row2)-x)-((length(table1)-length(row1))*length(row2))/length(table1))^2)/((length(table1)-length(row1))*length(row2))/length(table1));
            table5(k, 6) = (abs(length(row1)-length(row2))/x);
            k = k + 1;
        end
    end
end

disp("3item sets are getting ready in table6")
table6 = zeros(57, 3);
k = 1;
for i = 1:length(table1_temp)
   if length(table1_temp{i})==3
      table6(k, 1:3) = table1_temp{i}(1, 1:3);
      k = k + 1;
   elseif length(table1_temp{i})==4
      table6(k, 1:3) = table1_temp{i}(1, 1:3);
      k = k + 1;
      table6(k, 1:3) = table1_temp{i}(1, [1 2 4]);
      k = k + 1;
      table6(k, 1:3) = table1_temp{i}(1, 2:4);
      k = k + 1;
      table6(k, 1:3) = table1_temp{i}(1, [1 3 4]);
      k = k + 1;
   end
end
table6 = sortrows(table6);

table7 = zeros(57, 4);
k = 1;
for i = 1:length(table1_temp)
    for j = 1:length(table6)
        x = 0;
        if length(table1_temp{i})  == 3
            x = x + isequal(table1_temp{i}(1, 1:3), table6(j, :));
        elseif length(table1_temp{i})  == 4
            x = x + isequal(table1_temp{i}(1, 1:3), table6(j, :));
            x = x + isequal(table1_temp{i}(1, [1 2 4]), table6(j, :));
            x = x + isequal(table1_temp{i}(1, 2:4), table6(j, :));
            x = x + isequal(table1_temp{i}(1, [1 3 4]), table6(j, :));
        end
        if x >= minsup
            table7(k, 1:3) = table6(j, :);
            table7(k, 4) = x;
            k = k + 1;
        end
    end
end

disp("4item sets are getting ready in table8")
table8 = zeros(4, 4);
k = 1;
for i = 1:length(table1_temp)
   if length(table1_temp{i})==4
      table8(k, 1:4) = table1_temp{i}(1, 1:4);
      k = k + 1;
   end
end
table8 = sortrows(table8);

table9 = zeros(4, 5);
k = 1;
for i = 1:length(table1_temp)
    for j = 1:length(table8)
        x = 0;
        if length(table1_temp{i})  == 4
            x = x + isequal(table1_temp{i}(1, 1:4), table8(j, :));
        end
        if x >= minsup
            table9(k, 1:4) = table8(j, :);
            table9(k, 5) = x;
            k = k + 1;
        end
    end
end

table5