function video = init_video(P)



%imwrite(ones(P.ylim, P.xlim * 2 + 4), ...
%    [P.model_base '/' P.model_base '.gif'],'gif', 'DelayTime', 0.03);

video=0;

mkdir([P.model_base '/video/']);
%video = VideoWriter([P.model_base '/' P.model_base], 'Archival');
% video.Quality = 100;
%open(video);


end