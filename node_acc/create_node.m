% load breastcancer.mat
% ht = java.util.Hashtable;
% 
% x_train = breastcancer(1:400,1:9);
% y_train = breastcancer(1:400,10);
% 
% x_test = breastcancer(401:700,1:9);
% y_test = breastcancer(401:700,10);
% 
% num_dim = size(x_train,2)
% 
% set_index = zeros(1, num_dim);
% fileID = fopen('score.txt','w');
% 
% key_list = [];
% value_list = [];
% 
% for i1 = 0: 1
%     set_index(1) = i1;
%     for i2 = 0: 1
%         set_index(2) = i2;
%         for i3 = 0: 1
%             set_index(3) = i3;
%             for i4 = 0: 1
%                 set_index(4) = i4;
%                 for i5 = 0: 1
%                     set_index(5) = i5;
%                     for i6 = 0: 1
%                         set_index(6) = i6;
%                         for i7 = 0: 1
%                             set_index(7) = i7;
%                             for i8 = 0: 1
%                                 set_index(8) = i8;
%                                 for i9 = 0: 1
%                                     set_index(9) = i9;
%                                     [~, index] = find(set_index > 0);
%                                     x_train_sub = x_train;
%                                     x_test_sub = x_test;
%                                     x_train_sub(:,index) = []; 
%                                     x_test_sub(:,index) = [];
%                                     if isempty(x_train_sub)
%                                         accuracy = 0;
%                                         index_str = [];
%                                         for i = 1:9
%                                             index_str = [index_str num2str(1-set_index(i))];
%                                         end
%                                         ht.put(index_str, accuracy);
%                                         fprintf(fileID, '%s %f\n', index_str, accuracy);
%                                         key_list = [key_list; set_index];
%                                         value_list = [value_list accuracy];
%                                         break;
%                                     end
%                                     tree = fitctree(x_train_sub,y_train);
%                                     result = predict(tree,x_test_sub);
%                                     accuracy = sum(result == y_test)/size(x_test,1);
%                                     index_str = [];
%                                     for i = 1:9
%                                         index_str = [index_str num2str(1-set_index(i))];
%                                     end
%                                     ht.put(index_str, accuracy);
%                                     key_list = [key_list; set_index];
%                                     value_list = [value_list accuracy];
%                                     fprintf(fileID, '%s %f\n', index_str, accuracy);
%                                 end
%                             end
%                         end
%                     end
%                 end
%             end
%         end
%     end
% end

mean_value = [];
for i = 1:9
    values = value_list(find(sum(key_list,2) == i));
    mean_value = [mean_value mean(values)];
end

plot(mean_value);
hold on

mean_value = [];
for i = 1:9
    values = value_list(find(sum(key_list,2) == i));
    mean_value = [mean_value max(values)];
end

plot(mean_value);
hold on

mean_value = [];
for i = 1:9
    values = value_list(find(sum(key_list,2) == i));
    mean_value = [mean_value min(values)];
end

plot(mean_value);
hold on
% fclose(fileID);
