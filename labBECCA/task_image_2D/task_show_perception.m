function task_show_perception(task);

feature_activity = task.agent.feature_activity;
%attended_feature = task.agent.attended_feature;

span = task.fov_span;
feature_activity{1} = zeros( task.state_length, 1);
%attended_feature{1} = zeros( task.state_length, 1);
feature_activity_expanded = agent_expand( task.agent, feature_activity);
%attended_feature_expanded = agent_expand( task.agent, attended_feature);

pos_indx = 1:task.state_length / 2;
neg_indx = task.state_length/2 + 1: task.state_length;
pos_indx = pos_indx(:);
neg_indx = neg_indx(:);

%creates the image set representing the perceived features in aggregate
pos_mask = find( feature_activity_expanded{1}(pos_indx) < 2);
neg_mask = find( feature_activity_expanded{1}(neg_indx) < 2);        
mask_indx = union( pos_mask, neg_mask);
        
feature_activity_image = ones( size( pos_indx));
feature_activity_image( pos_mask) = 0;
feature_activity_image( neg_mask) = 0;
feature_activity_image( pos_mask) = ...
    feature_activity_image( pos_mask) + ...
    feature_activity_expanded{1}(pos_mask);
feature_activity_image( neg_mask) = ...
    feature_activity_image( neg_mask) - ...
    feature_activity_expanded{1}(neg_mask + task.state_length/2);
        
feature_activity_image( mask_indx) = ...
    (util_sigm(feature_activity_image( mask_indx) .* 2) + 1) / 2.5; 
feature_activity_image = reshape( feature_activity_image, [span span]);

%creates the image set representing the perceived features in aggregate
% pos_mask = find( attended_feature_expanded{1}(pos_indx) < 2);
% neg_mask = find( attended_feature_expanded{1}(neg_indx) < 2);        
% mask_indx = union( pos_mask, neg_mask);
        
% attended_feature_image = ones( size( pos_indx));
% attended_feature_image( pos_mask) = 0;
% attended_feature_image( neg_mask) = 0;
% attended_feature_image( pos_mask) = ...
%     attended_feature_image( pos_mask) + ...
%     attended_feature_expanded{1}(pos_mask);
% attended_feature_image( neg_mask) = ...
%     attended_feature_image( neg_mask) - ...
%     attended_feature_expanded{1}(neg_mask + task.state_length/2);
%         
% attended_feature_image( mask_indx) = ...
%     (util_sigm(attended_feature_image( mask_indx) .* 2) + 1) / 2.5; 
% 
% attended_feature_image = reshape( attended_feature_image, [span span]);
% 
figure(2)
clf
subplot (1, 4, 1)
image(task.fov)
title('agent field of view')
axis equal

subplot (1, 4, 2)
sensory_composite = task.sensory_input( pos_indx) - ...
                    task.sensory_input( neg_indx);
sensed_image = reshape( sensory_composite, span, span);
%remaps [-1, 1] to [0, 4/5] for display
sensed_image = (sensed_image + 1) / 2.5;
image(sensed_image * 256)
title('sensed inputs')
axis equal

subplot (1, 4, 3)
mask_indx = find( feature_activity_image < 1.0);
feature_activity_image_final = ones( size( feature_activity_image));
feature_activity_image_final( mask_indx) = feature_activity_image( mask_indx);
image(feature_activity_image_final * 256)
title('perception through features')
axis equal

% subplot (1, 4, 4)
% mask_indx = find( attended_feature_image < 1.0);
% attended_feature_image_final = ones( size( attended_feature_image));
% attended_feature_image_final( mask_indx) = attended_feature_image( mask_indx);
% image(attended_feature_image_final * 256)
% title('attended feature')
% axis equal

drawnow