import { Download as DownloadIcon, FileText, FileSpreadsheet, FileType, FileImage } from 'lucide-react';

const downloads = [
  {
    id: 1,
    name: 'GMP Training Manual',
    type: 'PDF',
    size: '4.2 MB',
    date: 'March 10, 2026',
    icon: FileType,
    color: 'text-red-600'
  },
  {
    id: 2,
    name: 'Safety SOP Checklist',
    type: 'PDF',
    size: '1.8 MB',
    date: 'March 8, 2026',
    icon: FileType,
    color: 'text-red-600'
  },
  {
    id: 3,
    name: 'Quality Control Template',
    type: 'Excel',
    size: '2.1 MB',
    date: 'March 5, 2026',
    icon: FileSpreadsheet,
    color: 'text-green-600'
  },
  {
    id: 4,
    name: 'Course Certificates',
    type: 'PDF',
    size: '850 KB',
    date: 'March 1, 2026',
    icon: FileType,
    color: 'text-red-600'
  },
  {
    id: 5,
    name: 'GMP Compliance Guidelines',
    type: 'PDF',
    size: '5.6 MB',
    date: 'February 28, 2026',
    icon: FileType,
    color: 'text-red-600'
  },
  {
    id: 6,
    name: 'Cleanroom Diagrams',
    type: 'Image',
    size: '3.4 MB',
    date: 'February 25, 2026',
    icon: FileImage,
    color: 'text-blue-600'
  },
  {
    id: 7,
    name: 'Training Progress Report',
    type: 'Excel',
    size: '1.2 MB',
    date: 'February 20, 2026',
    icon: FileSpreadsheet,
    color: 'text-green-600'
  },
  {
    id: 8,
    name: 'Regulatory Requirements',
    type: 'Document',
    size: '920 KB',
    date: 'February 15, 2026',
    icon: FileText,
    color: 'text-gray-600'
  }
];

export function Download() {
  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-semibold mb-2">Downloads</h1>
          <p className="text-gray-600">Access course materials and certificates</p>
        </div>
        
        <button className="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors">
          Filter by Type
        </button>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-4 gap-6">
        <div className="bg-white rounded-lg border border-gray-200 p-6">
          <div className="flex items-center justify-between mb-2">
            <h3 className="text-sm text-gray-600">Total Files</h3>
            <FileText className="w-5 h-5 text-gray-400" />
          </div>
          <p className="text-3xl font-semibold">8</p>
        </div>
        
        <div className="bg-white rounded-lg border border-gray-200 p-6">
          <div className="flex items-center justify-between mb-2">
            <h3 className="text-sm text-gray-600">PDFs</h3>
            <FileType className="w-5 h-5 text-red-600" />
          </div>
          <p className="text-3xl font-semibold">5</p>
        </div>
        
        <div className="bg-white rounded-lg border border-gray-200 p-6">
          <div className="flex items-center justify-between mb-2">
            <h3 className="text-sm text-gray-600">Spreadsheets</h3>
            <FileSpreadsheet className="w-5 h-5 text-green-600" />
          </div>
          <p className="text-3xl font-semibold">2</p>
        </div>
        
        <div className="bg-white rounded-lg border border-gray-200 p-6">
          <div className="flex items-center justify-between mb-2">
            <h3 className="text-sm text-gray-600">Total Size</h3>
            <DownloadIcon className="w-5 h-5 text-gray-400" />
          </div>
          <p className="text-3xl font-semibold">20 MB</p>
        </div>
      </div>

      {/* Downloads List */}
      <div className="bg-white rounded-lg border border-gray-200">
        {downloads.map((file, index) => {
          const Icon = file.icon;
          return (
            <div
              key={file.id}
              className={`p-6 hover:bg-gray-50 transition-colors ${
                index !== downloads.length - 1 ? 'border-b border-gray-200' : ''
              }`}
            >
              <div className="flex items-center gap-6">
                {/* File Icon */}
                <div className="w-12 h-12 bg-gray-100 rounded-lg flex items-center justify-center flex-shrink-0">
                  <Icon className={`w-6 h-6 ${file.color}`} />
                </div>

                {/* File Info */}
                <div className="flex-1">
                  <h3 className="font-semibold mb-1">{file.name}</h3>
                  <div className="flex items-center gap-4 text-sm text-gray-600">
                    <span>{file.type}</span>
                    <span>•</span>
                    <span>{file.size}</span>
                    <span>•</span>
                    <span>{file.date}</span>
                  </div>
                </div>

                {/* Download Button */}
                <button className="flex items-center gap-2 px-4 py-2 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition-colors">
                  <DownloadIcon className="w-4 h-4" />
                  Download
                </button>
              </div>
            </div>
          );
        })}
      </div>
    </div>
  );
}