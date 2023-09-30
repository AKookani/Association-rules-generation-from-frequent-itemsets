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

 table4 = zeros(nchoosek(length(table3),2), 2);
 
 k = 1;
 for i = 1:length(table3)
     for j = i+1:length(table3)
         table4(k,1) = table3(i,1);
         table4(k,2) = table3(j,1);
         k = k + 1;
     end
 end
 
disp("3item sets are getting ready in table5")
table5 = zeros(41, 3);
k = 1;
for i = 1:length(table1_temp)
   if length(table1_temp{i})==3
      table5(k, 1:3) = table1_temp{i};
      k = k + 1;
   end
end
table5 = sortrows(table5);

disp("4item sets are getting ready in table6")
table6 = zeros(4, 4);
k = 1;
for i = 1:length(table1_temp)
   if length(table1_temp{i})==4
      table6(k, 1:4) = table1_temp{i};
      k = k + 1;
   end
end
table6 = sortrows(table6);

for i = 1:length(table4)
    x = 0;
    row = find(table4(:, 1) == table4(i, 1));
    for j = 1:length(row)
        if table4(i, 2) == table4(row(j), 2)
            x = x + 1;
        end
    end
    table4(i, 3) = x;
end
