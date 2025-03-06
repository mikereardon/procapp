# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# db/seeds.rb

# Clear existing data
puts "Clearing existing data..."
LineItem.delete_all
ProposalSection.delete_all
Proposal.delete_all
RfpInterest.delete_all
Rfp.delete_all
User.delete_all

# Create buyer companies
puts "Creating buyer companies..."

buyer_companies = [
  {
    name: "ChemTech Solutions",
    email: "admin@chemtech-solutions.com",
    description: "Chemical processing equipment manufacturer"
  },
  {
    name: "GlobalPetro Industries",
    email: "admin@globalpetro.com",
    description: "Oil refinery and petrochemical equipment provider"
  },
  {
    name: "PharmaProcess Systems",
    email: "admin@pharmaprocess.com",
    description: "Pharmaceutical manufacturing equipment supplier"
  },
  {
    name: "FoodTech Innovations",
    email: "admin@foodtech-innovations.com",
    description: "Food processing equipment manufacturer"
  },
  {
    name: "WaterTreat Solutions",
    email: "admin@watertreat.com",
    description: "Water treatment plant equipment provider"
  },
  {
    name: "MetalWorks Manufacturing",
    email: "admin@metalworks-mfg.com",
    description: "Metal fabrication and processing equipment"
  }
]

buyer_users = buyer_companies.map do |company|
  User.create!(
    email: company[:email],
    password: "password",
    password_confirmation: "password",
    company_name: company[:name],
    role: "buyer"
  )
end

# Create supplier companies
puts "Creating supplier companies..."

supplier_companies = [
  {
    name: "ProcessPro Engineering",
    email: "admin@processpro.com",
    description: "Industrial process engineering firm"
  },
  {
    name: "ValveTech Specialists",
    email: "admin@valvetech.com",
    description: "Industrial valve manufacturer"
  },
  {
    name: "PumpSystems International",
    email: "admin@pumpsystems.com",
    description: "Industrial pump solutions provider"
  },
  {
    name: "ControlLogix Automation",
    email: "admin@controllogix.com",
    description: "Process control and automation systems"
  },
  {
    name: "ThermalExchange Technologies",
    email: "admin@thermalexchange.com",
    description: "Heat exchanger and thermal equipment manufacturer"
  }
]

supplier_users = supplier_companies.map do |company|
  User.create!(
    email: company[:email],
    password: "password",
    password_confirmation: "password",
    company_name: company[:name],
    role: "supplier"
  )
end

# RFP data
puts "Creating RFPs..."

rfp_data = [
  {
    user: buyer_users[0], # ChemTech Solutions
    title: "Acid-Resistant Mixing Vessels for Chemical Processing",
    description: "We require three (3) 5000L acid-resistant mixing vessels for our new chemical processing facility. Vessels must withstand pH levels of 2-12, operating temperatures of -10°C to 120°C, and pressures up to 5 bar. Must include agitation systems, temperature control, and be compliant with ASME BPVC Section VIII standards. Material of construction should be either high-grade stainless steel (316L) or fiber-reinforced plastic (FRP) with appropriate linings.",
    deadline: 60
  },
  {
    user: buyer_users[0], # ChemTech Solutions
    title: "Chemical Dosing Skid System for Water Treatment",
    description: "Seeking proposals for the design and fabrication of a complete chemical dosing skid system for our water treatment process. The system should include metering pumps for sodium hypochlorite, caustic soda, and polymer, with flow rates ranging from 0.5 to 10 L/hour. Must include calibration columns, pulsation dampeners, pressure relief valves, and a PLC-based control system with HMI interface. All components must be chemically compatible and the system should be mounted on a skid for easy installation.",
    deadline: 45
  },
  {
    user: buyer_users[1], # GlobalPetro Industries
    title: "High-Pressure Heat Exchangers for Refinery Process",
    description: "GlobalPetro Industries is seeking proposals for the design and manufacture of six (6) high-pressure shell and tube heat exchangers for our refinery expansion project. Units must operate at pressures up to 150 bar and temperatures up to 450°C. Materials must be suitable for sour service (NACE MR0175 compliant). Thermal duty ranging from 2MW to 5MW per exchanger. Design must comply with TEMA standards and ASME BPVC Section VIII Division 1. Proposals should include full documentation, quality plan, and inspection requirements.",
    deadline: 75
  },
  {
    user: buyer_users[2], # PharmaProcess Systems
    title: "Clean-in-Place (CIP) System for Pharmaceutical Production",
    description: "PharmaProcess Systems requires a fully automated Clean-in-Place (CIP) system for our sterile injectable manufacturing facility. The system must include CIP supply and return stations, chemical dosing system, heat exchangers, spray devices, and a control system validated to GAMP 5 standards. All wetted parts must be 316L stainless steel with surface finish of 0.4μm Ra or better. System must be designed to comply with FDA and EMA requirements for pharmaceutical manufacturing and include complete validation documentation package.",
    deadline: 90
  },
  {
    user: buyer_users[3], # FoodTech Innovations
    title: "Continuous Freezing Tunnel for Food Processing Line",
    description: "FoodTech Innovations is soliciting proposals for a continuous freezing tunnel for our new ready-meal production line. The system should be capable of processing 1,500 kg/hour of packaged meals from 80°C to -18°C core temperature within 60 minutes. The tunnel should use mechanical refrigeration with environmentally friendly refrigerants (low GWP), include a CIP system, and comply with all food safety regulations. Proposals should include installation, commissioning, and operator training.",
    deadline: 30
  },
  {
    user: buyer_users[4], # WaterTreat Solutions
    title: "Reverse Osmosis System for Industrial Water Treatment Plant",
    description: "WaterTreat Solutions is seeking proposals for a complete reverse osmosis (RO) system for our industrial water treatment plant. The system should be capable of producing 500 m³/day of purified water with TDS reduction efficiency of 98% minimum. Required components include pretreatment (multimedia filtration, carbon filtration, antiscalant dosing), RO membrane array (two-pass configuration), clean-in-place system, and post-treatment. System should include instrumentation and controls with remote monitoring capabilities. Energy recovery devices should be incorporated to optimize energy efficiency.",
    deadline: 45
  },
  {
    user: buyer_users[5], # MetalWorks Manufacturing
    title: "Automated Metal Cutting and Forming Line",
    description: "MetalWorks Manufacturing requires an automated metal cutting and forming line for stainless steel sheet processing. The system should handle sheets up to 3m x 1.5m with thickness ranging from 1mm to 10mm. Required components include sheet loading system, plasma cutting station, press brake with programmable bending sequences, and automated material handling between stations. The control system should allow for integration with our existing MES system. Proposals should include equipment specifications, layout drawings, installation plan, and operator training program.",
    deadline: 60
  },
  {
    user: buyer_users[1], # GlobalPetro Industries
    title: "Flare Gas Recovery System for Petroleum Refinery",
    description: "GlobalPetro Industries is seeking proposals for a flare gas recovery system to reduce flaring at our main petroleum refinery. The system should be capable of recovering up to 10,000 Nm³/hr of flare gas with varying composition, including hydrogen, methane, ethane, and heavier hydrocarbons. Required components include liquid seal drum, knockout drums, compressors, coolers, and control system. The system must comply with environmental regulations and include emissions monitoring equipment. Proposals should address safety considerations, reliability, and maintenance requirements.",
    deadline: 90
  },
  {
    user: buyer_users[2], # PharmaProcess Systems
    title: "High-Purity Steam Generator for Pharmaceutical Manufacturing",
    description: "PharmaProcess Systems is seeking proposals for a high-purity steam generator for our sterile manufacturing facility. The system must produce clean steam compliant with HTM 2031 and EN 285 standards, with a capacity of 1,000 kg/hr at 3 bar(g). Required features include feed water pre-treatment system, degassing system, multiple clean steam distribution points, and automated controls with data logging for regulatory compliance. All components must be constructed of 316L stainless steel with appropriate surface finish. Proposals should include validation protocol documentation and IQ/OQ/PQ support.",
    deadline: 60
  },
  {
    user: buyer_users[3], # FoodTech Innovations
    title: "Automated Packaging Line for Ready-to-Eat Meals",
    description: "FoodTech Innovations requires an automated packaging line for our ready-to-eat meal production facility. The system should handle 60 trays per minute with capabilities for filling, sealing, labeling, and case packing. The line must include a tray denester, multi-head weigher for accurate ingredient dispensing, MAP (Modified Atmosphere Packaging) system, top-seal applicator, metal detector, checkweigher, and robotic case packer. All equipment must meet food safety standards (FSSC 22000) and be designed for easy cleaning and maintenance. The control system should integrate with our existing MES and provide OEE monitoring.",
    deadline: 75
  },
  {
    user: buyer_users[4], # WaterTreat Solutions
    title: "Membrane Bioreactor (MBR) System for Municipal Wastewater Treatment",
    description: "WaterTreat Solutions is soliciting proposals for a complete membrane bioreactor system for municipal wastewater treatment with a capacity of 5,000 m³/day. The system should include fine screening, biological treatment with anoxic and aerobic zones for nutrient removal, submerged ultrafiltration membranes, and sludge handling equipment. Required features include automated membrane cleaning systems, advanced process controls for energy optimization, and remote monitoring capabilities. The proposal should address membrane life expectancy, energy consumption, and maintenance requirements. The system must meet effluent quality standards of BOD < 5 mg/L, TSS < 1 mg/L, TN < 10 mg/L, and TP < 1 mg/L.",
    deadline: 90
  },
  {
    user: buyer_users[5], # MetalWorks Manufacturing
    title: "CNC Pipe Bending and End-Forming System",
    description: "MetalWorks Manufacturing is seeking proposals for a CNC pipe bending and end-forming system for our fabrication shop. The system should handle stainless steel, carbon steel, and alloy pipes with diameters from 25mm to 150mm and wall thicknesses up to 10mm. Required capabilities include multi-radius bending, push bending, roll bending, and end forming operations (flaring, reducing, beading). The control system should allow for importing 3D CAD files and generating bending programs automatically. The proposal should include machine specifications, tooling packages, installation requirements, and operator training program. Equipment must comply with CE marking and ISO safety standards.",
    deadline: 45
  },
  {
    user: buyer_users[0], # ChemTech Solutions
    title: "Pilot Scale Continuous Flow Reactor System",
    description: "ChemTech Solutions requires a pilot scale continuous flow reactor system for process development of specialty chemicals. The system should include feed preparation tanks, high-pressure pumps, heat exchangers, tubular reactor modules with multiple temperature zones, back-pressure regulators, and product collection vessels. Operating parameters should include pressures up to 50 bar, temperatures from -20°C to 200°C, and flow rates from 10 mL/min to 1 L/min. Construction materials must be compatible with corrosive chemicals and organic solvents. The control system should allow for recipe-based operation and data logging of all process parameters. Proposals should include detailed P&ID, equipment specifications, and control system architecture.",
    deadline: 60
  },
  {
    user: buyer_users[1], # GlobalPetro Industries
    title: "Sulfur Recovery Unit for Natural Gas Processing",
    description: "GlobalPetro Industries is seeking proposals for a sulfur recovery unit (SRU) for our natural gas processing facility. The unit should have a capacity to process 20 tonnes per day of sulfur from acid gas streams containing H₂S and CO₂. The system should include thermal reaction furnace, waste heat boiler, catalytic converters (minimum 2 stages), sulfur condensers, and tail gas treating unit. Required efficiency is minimum 99.5% sulfur recovery. The proposal should address emissions compliance, turndown capabilities, and catalyst life expectancy. Design should comply with relevant API standards and local environmental regulations. Proposals should include HAZOP study, construction timeline, and commissioning plan.",
    deadline: 120
  },
  {
    user: buyer_users[3], # FoodTech Innovations
    title: "Hygienic Powder Mixing and Blending System",
    description: "FoodTech Innovations requires a hygienic powder mixing and blending system for our nutritional supplements production facility. The system should handle batch sizes from 100kg to 500kg with ingredients ranging from fine powders to granules. Required features include ingredient delivery systems, screening, precision weighing, ribbon blender with vacuum capability, and packaging interface. All equipment must be designed to EHEDG hygienic standards with 304/316 stainless steel construction, minimal horizontal surfaces, and tool-free disassembly for cleaning. The system should include dust control, explosion protection (ATEX compliant), and full batch traceability. Proposals should include factory acceptance testing protocol and installation requirements.",
    deadline: 45
  },
  {
    user: buyer_users[2], # PharmaProcess Systems
    title: "Tablet Coating System for Pharmaceutical Production",
    description: "PharmaProcess Systems is seeking proposals for a fully automated tablet coating system for our oral solid dosage manufacturing facility. The system should include a coating pan (perforated drum type) with working capacity of 150-250kg, spray delivery system, air handling unit, PLC-based control system, and PAT (Process Analytical Technology) tools for coating endpoint determination. The equipment must be GMP compliant with 316L stainless steel construction, automated clean-in-place capabilities, and full containment for both aqueous and organic solvent-based coating operations. Proposals should include FAT/SAT protocols, validation support documentation, and operator training program.",
    deadline: 75
  }
]

created_rfps = rfp_data.map do |rfp_info|
  rfp = Rfp.create!(
    user: rfp_info[:user],
    title: rfp_info[:title],
    description: rfp_info[:description],
    submission_deadline: Time.now + rfp_info[:deadline].days,
    status: "published"
  )

  # Randomly assign some suppliers as interested
  supplier_users.sample(rand(1..3)).each do |supplier|
    RfpInterest.create!(
      user: supplier,
      rfp: rfp
    )
  end

  rfp
end

puts "Creating proposals for some RFPs..."

# Create some proposals
created_rfps.sample(4).each do |rfp|
  # Get interested suppliers
  interested_suppliers = rfp.interested_suppliers

  # For each interested supplier, 50% chance to create a proposal
  interested_suppliers.each do |supplier|
    next unless rand < 0.5

    proposal = Proposal.create!(
      user: supplier,
      rfp: rfp,
      title: "#{supplier.company_name} Proposal for #{rfp.title.truncate(30)}",
      status: [ "draft", "submitted", "submitted", "under_review" ].sample
    )

    # Create sections
    sections = [
      {
        title: "Executive Summary",
        content: "<div>#{supplier.company_name} is pleased to present this proposal for #{rfp.title}. Our solution addresses all requirements while providing excellent value and reliability. With our extensive experience in this field, we are confident in our ability to deliver a high-quality solution that meets your specifications and timeline requirements.</div>",
        position: 1
      },
      {
        title: "Approach & Methodology",
        content: "<div><p>Our approach to this project will follow our proven methodology:</p><ul><li>Detailed requirements analysis and engineering design</li><li>Component procurement from trusted suppliers</li><li>Fabrication and assembly in our ISO 9001 certified facility</li><li>Comprehensive factory acceptance testing</li><li>Professional installation and commissioning</li><li>Thorough documentation and training</li></ul><p>We will assign a dedicated project manager to oversee all aspects of the project and ensure clear communication throughout.</p></div>",
        position: 2
      },
      {
        title: "Timeline",
        content: "<div><p>We propose the following timeline for project execution:</p><ul><li>Engineering and Design: 3-4 weeks</li><li>Procurement: 4-6 weeks</li><li>Fabrication and Assembly: 6-8 weeks</li><li>Factory Testing: 1-2 weeks</li><li>Delivery: 1 week</li><li>Installation and Commissioning: 2-3 weeks</li></ul><p>Total project duration: 16-24 weeks from contract award.</p></div>",
        position: 3
      },
      {
        title: "Team & Experience",
        content: "<div><p>Our project team consists of experienced professionals with relevant expertise:</p><ul><li>Project Manager: 15+ years of experience in similar projects</li><li>Lead Engineer: Expert in process design with appropriate certifications</li><li>Fabrication Supervisor: 20+ years of experience in equipment manufacturing</li><li>Quality Control Specialist: Certified inspector for all relevant standards</li><li>Commissioning Engineer: Specialized in system startup and troubleshooting</li></ul><p>Our company has successfully completed over 50 similar projects in the past 10 years.</p></div>",
        position: 4
      },
      {
        title: "Additional Information",
        content: "<div><p>Our proposal includes the following additional benefits:</p><ul><li>24/7 technical support for the first 3 months after commissioning</li><li>Comprehensive warranty for 18 months from delivery or 12 months from commissioning</li><li>Availability of spare parts for a minimum of 10 years</li><li>Optional maintenance contracts available</li><li>Remote monitoring and diagnostic capabilities</li></ul></div>",
        position: 5
      }
    ]

    sections.each do |section_data|
      section = ProposalSection.create!(
        proposal: proposal,
        title: section_data[:title],
        position: section_data[:position]
      )

      # Set rich text content
      section.update(content: section_data[:content])
    end

    # Create line items
    items = [
      {
        description: "Equipment design and engineering",
        quantity: rand(1..1),
        unit_price: rand(10000..25000)
      },
      {
        description: "Main equipment/system components",
        quantity: rand(1..5),
        unit_price: rand(15000..75000)
      },
      {
        description: "Control system and instrumentation",
        quantity: rand(1..1),
        unit_price: rand(8000..20000)
      },
      {
        description: "Installation and commissioning",
        quantity: rand(1..1),
        unit_price: rand(7500..15000)
      },
      {
        description: "Documentation and training",
        quantity: rand(1..1),
        unit_price: rand(3000..7500)
      }
    ]

    # Add random subset of items (at least 3)
    items.sample(rand(3..5)).each do |item_data|
      LineItem.create!(
        proposal: proposal,
        description: item_data[:description],
        quantity: item_data[:quantity],
        unit_price: item_data[:unit_price]
      )
    end
  end
end

puts "Seed data created successfully!"
puts "Created:"
puts "  - #{User.where(role: 'buyer').count} buyer companies"
puts "  - #{User.where(role: 'supplier').count} supplier companies"
puts "  - #{Rfp.count} RFPs"
puts "  - #{RfpInterest.count} interests registered"
puts "  - #{Proposal.count} proposals"
puts "  - #{ProposalSection.count} proposal sections"
puts "  - #{LineItem.count} line items"
puts ""
puts "All users have password: 'password'"


# Add test accounts for easy login
puts "Creating test accounts..."

# Test buyer
test_buyer = User.create!(
  email: "test@buyer.com",
  password: "password",
  password_confirmation: "password",
  company_name: "Test Buyer Corporation",
  role: "buyer"
)

# Test supplier
test_supplier = User.create!(
  email: "test@vendor.com",
  password: "password",
  password_confirmation: "password",
  company_name: "Test Vendor Ltd.",
  role: "supplier"
)

# Add to the arrays for reference
buyer_users << test_buyer
supplier_users << test_supplier

# Create a couple of RFPs from the test buyer
test_rfp_data = [
  {
    user: test_buyer,
    title: "Industrial Centrifuge for Chemical Separation",
    description: "Test Buyer Corporation is seeking proposals for an industrial centrifuge system for separating chemical compounds. The system should handle flow rates of 5-10 m³/hour with particle sizes down to 5 microns. Required features include automatic discharge, CIP capabilities, explosion-proof design, and PLC controls. The system will be processing corrosive chemicals, so materials of construction should be appropriate (Hastelloy, titanium, or lined steel). Proposals should include technical specifications, installation requirements, and maintenance recommendations.",
    deadline: 30
  },
  {
    user: test_buyer,
    title: "Steam Boiler System for Process Heating",
    description: "Test Buyer Corporation requires a new steam boiler system for our manufacturing facility. The system should provide 5000 kg/hr of steam at 10 bar pressure. Required components include feed water treatment, economizer, condensate recovery system, and digital controls with remote monitoring. Boiler efficiency should be minimum 85% with low NOx emissions. Proposals should address fuel options (natural gas primary with oil backup), installation requirements, and commissioning plan. All equipment must comply with relevant pressure vessel standards and local regulations.",
    deadline: 45
  }
]

# Create the test RFPs
test_rfp_data.each do |rfp_info|
  rfp = Rfp.create!(
    user: rfp_info[:user],
    title: rfp_info[:title],
    description: rfp_info[:description],
    submission_deadline: Time.now + rfp_info[:deadline].days,
    status: "published"
  )

  # Register interest from the test supplier
  RfpInterest.create!(
    user: test_supplier,
    rfp: rfp
  )

  created_rfps << rfp
end

puts "Test accounts created:"
puts "  - Buyer: test@buyer.com / password"
puts "  - Vendor: test@vendor.com / password"
