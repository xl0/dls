function record_css(avg, P)

rgb = ind2rgb(round(avg), jet(70));



color = sprintf('#%2.2x%2.2x%2.2x', round(rgb(1)*255), ...
                           round(rgb(2)*255), ...
                           round(rgb(3)*255));

f = fopen([P.model_base '.css'], 'w+');
fprintf(f, ['a.' P.model_base ' {\n']);
fprintf(f, ['background-color: ' color ';\n']);
fprintf(f, '}\n');

fclose(f);



end