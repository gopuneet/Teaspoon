SELECT epoch, branch, scenario, feature, success FROM scenarios AS s LEFT JOIN epoch_ids AS ei ON ei.id = s.epoch_id LEFT JOIN scenario_ids AS si ON s.scenario_id = si.id LEFT JOIN branch_ids AS bi ON s.branch_id = bi.id LEFT JOIN feature_ids AS fi ON s.feature_id = fi.id