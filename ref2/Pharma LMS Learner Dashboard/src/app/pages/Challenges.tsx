import { Trophy, Target, Users, Clock } from 'lucide-react';

const challenges = [
  {
    id: 1,
    title: 'GMP Master Challenge',
    description: 'Complete all GMP modules with a score of 90% or higher',
    progress: 75,
    reward: '500 points',
    deadline: '7 days left',
    participants: 142
  },
  {
    id: 2,
    title: 'Safety First',
    description: 'Complete Safety SOP course and pass the final exam',
    progress: 45,
    reward: '300 points',
    deadline: '14 days left',
    participants: 98
  },
  {
    id: 3,
    title: 'Quality Champion',
    description: 'Achieve 100% in all Quality Control assessments',
    progress: 20,
    reward: '750 points',
    deadline: '21 days left',
    participants: 67
  },
  {
    id: 4,
    title: 'Learning Streak',
    description: 'Complete at least one lesson every day for 30 days',
    progress: 60,
    reward: '1000 points',
    deadline: '18 days left',
    participants: 234
  }
];

export function Challenges() {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-semibold mb-2">Challenges</h1>
        <p className="text-gray-600">Complete challenges to earn points and badges</p>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-3 gap-6">
        <div className="bg-white rounded-lg border border-gray-200 p-6">
          <div className="flex items-center justify-between mb-2">
            <h3 className="text-sm text-gray-600">Active Challenges</h3>
            <Target className="w-5 h-5 text-emerald-600" />
          </div>
          <p className="text-3xl font-semibold">4</p>
        </div>
        
        <div className="bg-white rounded-lg border border-gray-200 p-6">
          <div className="flex items-center justify-between mb-2">
            <h3 className="text-sm text-gray-600">Completed</h3>
            <Trophy className="w-5 h-5 text-amber-500" />
          </div>
          <p className="text-3xl font-semibold">12</p>
        </div>
        
        <div className="bg-white rounded-lg border border-gray-200 p-6">
          <div className="flex items-center justify-between mb-2">
            <h3 className="text-sm text-gray-600">Total Points</h3>
            <Trophy className="w-5 h-5 text-gray-400" />
          </div>
          <p className="text-3xl font-semibold">4,250</p>
        </div>
      </div>

      {/* Challenges Grid */}
      <div className="grid grid-cols-2 gap-6">
        {challenges.map((challenge) => (
          <div
            key={challenge.id}
            className="bg-white rounded-lg border border-gray-200 p-6 hover:shadow-md transition-shadow"
          >
            <div className="flex items-start justify-between mb-4">
              <div className="flex-1">
                <h3 className="text-lg font-semibold mb-2">{challenge.title}</h3>
                <p className="text-sm text-gray-600">{challenge.description}</p>
              </div>
              <div className="w-12 h-12 bg-emerald-100 rounded-lg flex items-center justify-center flex-shrink-0">
                <Trophy className="w-6 h-6 text-emerald-600" />
              </div>
            </div>

            {/* Progress */}
            <div className="mb-4">
              <div className="flex items-center justify-between text-sm mb-2">
                <span className="text-gray-600">Progress</span>
                <span className="font-medium text-emerald-600">{challenge.progress}%</span>
              </div>
              <div className="w-full bg-gray-200 rounded-full h-2">
                <div
                  className="bg-emerald-600 h-2 rounded-full transition-all"
                  style={{ width: `${challenge.progress}%` }}
                />
              </div>
            </div>

            {/* Meta Info */}
            <div className="flex items-center justify-between text-sm">
              <div className="flex items-center gap-4 text-gray-600">
                <div className="flex items-center gap-1">
                  <Clock className="w-4 h-4" />
                  <span>{challenge.deadline}</span>
                </div>
                <div className="flex items-center gap-1">
                  <Users className="w-4 h-4" />
                  <span>{challenge.participants}</span>
                </div>
              </div>
              <span className="font-semibold text-emerald-600">{challenge.reward}</span>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
