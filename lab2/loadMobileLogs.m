Ts = 0.01;

struct_name = 'distance_measurement_logs';


logs = struct;
logs.acc_logs = m.accellog;
logs.angvel_logs = m.angvellog;
logs.orient_logs = m.orientlog;
logs.mag_logs = m.magfieldlog;

eval([struct_name, ' = logs']);
