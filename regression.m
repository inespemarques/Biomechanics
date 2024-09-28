function [corr, m, b] = regression(x, y)
    % Perform linear regression to find correlation (corr), slope (m), and intercept (b)

    % Ensure that x and y are column vectors
    x = x(:);
    y = y(:);

    % Check the sizes of x and y
    if length(x) ~= length(y)
        error('Input vectors x and y must have the same length.');
    end

    % Calculate the means of x and y
    x_mean = mean(x);
    y_mean = mean(y);

    % Calculate the terms needed for the slope (m) and intercept (b)
    numerator = sum((x - x_mean) .* (y - y_mean));
    denominator = sum((x - x_mean).^2);

    % Calculate the slope and intercept
    m = numerator / denominator;
    b = y_mean - m * x_mean;

    % Calculate the correlation coefficient
    corr = corrcoef(x, y);
    corr = corr(1, 2);  % Extract the correlation coefficient

    % You can use corr^2 if you want to square the correlation to get R-squared

    % Optionally, you can plot the regression line:
    % fitted_y = m * x + b;
    % plot(x, y, 'o', x, fitted_y, '-');

    % Alternatively, you can return the fitted values as well
    % fitted_y = m * x + b;
end
