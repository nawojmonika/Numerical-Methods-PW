function re = relativeError(expected, value)
    absoluteError = abs(expected - value);
    re = absoluteError / abs(value);
end
