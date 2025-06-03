function vline(xline, varargin)
  % This function draws vertical lines with text labels at bottom-right by default.
  %
  % Usage:
  %   vline(xline)                          % Lines with no text
  %   vline(xline, 'label', 'Text')         % Labels at bottom-right (default)
  %   vline(xline, 'label', {'A','B','C'})  % Custom labels
  %   vline(xline, 'labelpos', 'top-left')  % Custom position (e.g., 'top-left')
  %   vline(xline, 'color', 'r', 'linewidth', 2)  % Line styling
  %
  %   Author: Fabio Silvestrini
  %

  % Default settings
  label = [];
  labelpos = 'bottom-right';  % Changed default to bottom-right
  line_args = {};

  % Parse optional arguments
  for i = 1:2:length(varargin)
    switch lower(varargin{i})
      case 'label'
        label = varargin{i+1};
      case 'labelpos'
        labelpos = lower(varargin{i+1});
      otherwise
        line_args{end+1} = varargin{i};
        line_args{end+1} = varargin{i+1};
    end
  end

  % Get y-axis limits and calculate label positions
  yrange = ylim;
  ymin = yrange(1);
  ymax = yrange(2);
  offset = 0.01 * (ymax - ymin);  % Small offset from axes

  % Set label position based on `labelpos`
  switch labelpos
    case 'top-left'
      xtext = xline - offset;
      ytext = ymax - offset;
      horz_align = 'right';
      vert_align = 'top';
    case 'top-right'
      xtext = xline + offset;
      ytext = ymax - offset;
      horz_align = 'left';
      vert_align = 'top';
    case 'bottom-left'
      xtext = xline - offset;
      ytext = ymin + offset;
      horz_align = 'right';
      vert_align = 'bottom';
    otherwise  % 'bottom-right' (default)
      xtext = xline + offset;
      ytext = ymin + offset;
      horz_align = 'left';
      vert_align = 'bottom';
  end

  % Draw lines and labels
  hold on;
  for i = 1:length(xline)
    % Plot the line
    line([xline(i), xline(i)], [ymin, ymax], line_args{:});

    % Add label if provided
    if ~isempty(label)
      if iscell(label) && length(label) >= i
        text_str = label{i};
      else
        text_str = label;
      end

      text(xtext(i), ytext, text_str, ...
           'HorizontalAlignment', horz_align, ...
           'VerticalAlignment', vert_align, ...
           'BackgroundColor', 'none', ...
           'Margin', 1);
    end
  end
  hold off;
end
