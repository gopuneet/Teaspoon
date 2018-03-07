module Report
  def self.sample
    [
      {
        uri: 'features/one_passing_one_failing.feature',
        keyword: 'Feature',
        id: 'one-passing-scenario,-one-failing-scenario',
        name: 'One passing scenario, one failing scenario',
        line: 2,
        description: '',
        tags: [
          {
            name: '@a',
            line: 1
          }
        ],
        elements: [
          {
            keyword: 'Scenario',
            id: 'one-passing-scenario,-one-failing-scenario;passing',
            name: 'Passing',
            line: 5,
            description: '',
            tags: [
              {
                name: '@b',
                line: 4
              }
            ],
            type: 'scenario',
            steps: [
              {
                keyword: 'Given ',
                name: 'this step passes',
                line: 6,
                match: {
                  location: 'features/step_definitions/steps.rb:1'
                },
                result: {
                  status: 'passed',
                  duration: 1
                }
              }
            ]
          },
          {
            keyword: 'Scenario',
            id: 'one-passing-scenario,-one-failing-scenario;failing',
            name: 'Failing',
            line: 9,
            description: '',
            tags: [
              {
                name: '@c',
                line: 8
              }
            ],
            type: 'scenario',
            steps: [
              {
                keyword: 'Given ',
                name: 'this step fails',
                line: 10,
                match: {
                  location: 'features/step_definitions/steps.rb:4'
                },
                result: {
                  status: 'failed',
                  error_message: " (RuntimeError)\n./features/step_definitions/steps.rb:4:in /^this step fails$/'\nfeatures/one_passing_one_failing.feature:10:in Given this step fails'",
                  duration: 1
                }
              }
            ]
          }
        ]
      },
      {
        uri: 'features/one_failing_one_passing.feature',
        keyword: 'Feature',
        id: 'one-failing-scenario,-one-passing-scenario',
        name: 'One failing scenario, one passing scenario',
        line: 2,
        description: '',
        tags: [
          {
            name: '@a',
            line: 1
          }
        ],
        elements: [
          {
            keyword: 'Scenario',
            id: 'one-failing-scenario,-one-passing-scenario;passing',
            name: 'Passing',
            line: 5,
            description: '',
            tags: [
              {
                name: '@b',
                line: 4
              }
            ],
            type: 'scenario',
            steps: [
              {
                keyword: 'Given ',
                name: 'this step passes',
                line: 6,
                match: {
                  location: 'features/step_definitions/steps.rb:1'
                },
                result: {
                  status: 'passed',
                  duration: 1
                }
              }
            ]
          },
          {
            keyword: 'Scenario',
            id: 'one-failing-scenario,-one-passing-scenario;failing',
            name: 'Failing',
            line: 9,
            description: '',
            tags: [
              {
                name: '@c',
                line: 8
              }
            ],
            type: 'scenario',
            steps: [
              {
                keyword: 'Given ',
                name: 'this step fails',
                line: 10,
                match: {
                  location: 'features/step_definitions/steps.rb:4'
                },
                result: {
                  status: 'failed',
                  error_message: " (RuntimeError)\n./features/step_definitions/steps.rb:4:in /^this step fails$/'\nfeatures/one_passing_one_failing.feature:10:in Given this step fails'",
                  duration: 1
                }
              }
            ]
          }
        ]
      }
    ]
  end

  def self.in_database(epoch, branch)
    [
      { 'epoch' => epoch, 'branch' => branch, 'scenario' => 'Passing:5', 'success' => true, 'feature' => 'one-passing-scenario,-one-failing-scenario' },
      { 'epoch' => epoch, 'branch' => branch, 'scenario' => 'Failing:9', 'success' => false, 'feature' => 'one-passing-scenario,-one-failing-scenario' },
      { 'epoch' => epoch, 'branch' => branch, 'scenario' => 'Passing:5', 'success' => true, 'feature' => 'one-failing-scenario,-one-passing-scenario' },
      { 'epoch' => epoch, 'branch' => branch, 'scenario' => 'Failing:9', 'success' => false, 'feature' => 'one-failing-scenario,-one-passing-scenario' }
    ]
  end
end
