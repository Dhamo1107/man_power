professions = [
  # Construction
  "Carpenter", "Electrician", "Plumber", "Painter", "Mason", "Architect", "Civil Engineer", "Surveyor", "Welder", "HVAC Technician",
  # Healthcare
  "Doctor", "Nurse", "Pharmacist", "Dentist", "Physical Therapist", "Radiologist", "Occupational Therapist", "Paramedic", "Medical Laboratory Technician", "Surgeon",
  # Information Technology
  "Software Developer", "Web Developer", "Database Administrator", "Network Engineer", "IT Support Specialist", "Systems Analyst", "Cybersecurity Analyst", "Data Scientist", "UX/UI Designer", "Cloud Architect",
  # Education
  "Teacher", "Professor", "Tutor", "School Counselor", "Principal", "Educational Consultant", "Librarian", "Special Education Teacher", "Instructional Coordinator", "Educational Technologist",
  # Finance
  "Accountant", "Financial Analyst", "Investment Banker", "Auditor", "Tax Consultant", "Financial Planner", "Insurance Underwriter", "Loan Officer", "Credit Analyst", "Actuary",
  # Hospitality
  "Chef", "Hotel Manager", "Housekeeper", "Event Planner", "Bartender", "Concierge", "Travel Agent", "Tour Guide", "Front Desk Clerk", "Sommelier",
  # Manufacturing
  "Machine Operator", "Quality Control Inspector", "Production Supervisor", "Assembler", "Manufacturing Engineer", "Industrial Designer", "Maintenance Technician", "CNC Machinist", "Packaging Technician", "Welder",
  # Sales and Marketing
  "Sales Representative", "Marketing Manager", "Advertising Specialist", "Social Media Manager", "Public Relations Specialist", "Market Research Analyst", "Account Manager", "Brand Manager", "Retail Manager", "Customer Service Representative",
  # Transportation
  "Truck Driver", "Bus Driver", "Delivery Driver", "Pilot", "Train Conductor", "Ship Captain", "Logistics Coordinator", "Air Traffic Controller", "Freight Handler", "Dispatch Coordinator",
  # Arts and Entertainment
  "Graphic Designer", "Musician", "Actor", "Photographer", "Videographer", "Writer", "Dancer", "Art Director", "Animator", "Sound Engineer",
  # Legal
  "Lawyer", "Paralegal", "Legal Assistant", "Judge", "Legal Secretary", "Court Reporter", "Compliance Officer", "Corporate Counsel", "Mediator", "Notary Public",
  # Real Estate
  "Real Estate Agent", "Property Manager", "Appraiser", "Real Estate Broker", "Leasing Consultant", "Real Estate Developer", "Home Inspector", "Real Estate Attorney", "Title Examiner", "Mortgage Broker",
  # Retail
  "Cashier", "Store Manager", "Sales Associate", "Visual Merchandiser", "Inventory Specialist", "Retail Buyer", "Customer Service Representative", "Stock Clerk", "Loss Prevention Specialist", "Product Demonstrator",
  # Public Services
  "Police Officer", "Firefighter", "Social Worker", "Postal Worker", "Public Health Official", "Environmental Scientist", "Urban Planner", "Public Policy Analyst", "Emergency Management Director", "Government Clerk",
  # Agriculture
  "Farmer", "Agricultural Scientist", "Horticulturist", "Agronomist", "Rancher", "Agricultural Equipment Operator", "Beekeeper", "Dairy Farmer", "Agricultural Technician", "Fishery Worker",
  # Media and Communication
  "Journalist", "Editor", "Public Relations Specialist", "Broadcast Technician", "Copywriter", "Technical Writer", "Content Strategist", "Translator", "Radio Host", "Video Editor",
  # Engineering
  "Mechanical Engineer", "Electrical Engineer", "Civil Engineer", "Chemical Engineer", "Environmental Engineer", "Biomedical Engineer", "Aerospace Engineer", "Industrial Engineer", "Software Engineer", "Structural Engineer",
  # Fashion and Design
  "Fashion Designer", "Textile Designer", "Fashion Stylist", "Fashion Buyer", "Pattern Maker", "Tailor", "Fashion Illustrator", "Costume Designer", "Jewelry Designer", "Fashion Photographer",
  # Energy and Utilities
  "Electrician", "Power Plant Operator", "Wind Turbine Technician", "Solar Panel Installer", "Petroleum Engineer", "Energy Analyst", "Utility Worker", "Pipeline Technician", "Environmental Compliance Specialist", "Nuclear Engineer",
  # Telecommunications
  "Network Technician", "Telecommunications Engineer", "Cable Installer", "Satellite Technician", "RF Engineer", "Fiber Optic Technician", "Telecommunications Equipment Installer", "VoIP Engineer", "Telecommunications Manager", "Field Service Technician"
]

professions.each do |profession|
  Profession.find_or_create_by(name: profession)
end
