%-------------------------------------------------------------------------------
%                ACADEMIC CV - Custom LaTeX Class File
%-------------------------------------------------------------------------------
%
% Description:
% A custom LaTeX class for creating a professional, academic CV.
% Version 6.2: Further refined vertical spacing for project and entry descriptions.
%
%-------------------------------------------------------------------------------

%----- IDENTIFICATION ----------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{academic-cv}[2024/08/21 v6.2 Academic CV Class]

%----- BASE CLASS --------------------------------------------------------------
\LoadClass[11pt, a4paper]{article}

%----- REQUIRED PACKAGES -------------------------------------------------------
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{lmodern}
\usepackage[english]{babel}
\usepackage{geometry}
\usepackage{xcolor}
\usepackage{fontawesome5}
\usepackage{hyperref}
\usepackage{titlesec}
\usepackage{parskip}
\usepackage{tabularx}
\usepackage{fancyhdr}   % For custom footers
\usepackage{lastpage}   % For total page count

%----- GEOMETRY & LAYOUT -------------------------------------------------------
\geometry{
  left=1.8cm,
  right=1.8cm,
  top=1.5cm,
  bottom=2cm, % Increased bottom margin for footer
  footskip=1cm
}
\pagestyle{empty}

%----- COLORS & FONTS ----------------------------------------------------------
\definecolor{primarycolor}{HTML}{005A5B}
\definecolor{secondarycolor}{HTML}{2C3E50}
\definecolor{graytext}{HTML}{6a6a6a}
\definecolor{linkcolor}{HTML}{005A5B}

\usepackage{lato}
\renewcommand*\familydefault{\sfdefault}

\hypersetup{
    colorlinks=true,
    urlcolor=black,
    linkcolor=black,
    citecolor=black,
}

%----- HEADER & FOOTER SETUP ---------------------------------------------------
\pagestyle{fancy}
\fancyhf{} % Clear all header and footer fields
\renewcommand{\headrulewidth}{0pt} % No header rule
\renewcommand{\footrulewidth}{0pt} % Footer rule

% Define footer content
\newcommand{\footerdate}[1]{\def\@footerdate{#1}}
\fancyfoot[L]{\footnotesize\color{graytext} \@footerdate}
\fancyfoot[C]{\footnotesize\color{graytext} (Showkot Hossain)}
\fancyfoot[R]{\footnotesize\color{graytext} Page \thepage\ of \pageref{LastPage}}

%----- HEADER COMMANDS ---------------------------------------------------------
\newcommand{\cvname}[1]{\def\@cvname{#1}}
\newcommand{\cvposition}[1]{\def\@cvposition{#1}}
\newcommand{\cvaddress}[1]{\def\@cvaddress{#1}}
\newcommand{\cvemail}[1]{\def\@cvemail{#1}}
\newcommand{\cvphone}[1]{\def\@cvphone{#1}}
\newcommand{\cvsite}[1]{\def\@cvsite{#1}}
\newcommand{\cvgithub}[1]{\def\@cvgithub{#1}}
\newcommand{\cvlinkedin}[1]{\def\@cvlinkedin{#1}}
\newcommand{\cvscholar}[1]{\def\@cvscholar{#1}}
\newcommand{\cvresearchgate}[1]{\def\@cvresearchgate{#1}}

\newcommand{\makecvheader}{%
  \begin{center}
    {\Huge\bfseries\color{secondarycolor} \@cvname}\\[4pt]
    {\Large\color{primarycolor} \@cvposition}
  \end{center}
  \vspace{6pt}
  \begin{center}
    \small\color{secondarycolor}
    \faMapMarkerAlt~\@cvaddress \\[4pt]
    \faPhone~\@cvphone \quad\textbar\quad
    \href{mailto:\@cvemail}{\faEnvelope~\@cvemail} \quad\textbar\quad
    \href{http://\@cvsite}{\faGlobe~\@cvsite} \quad\textbar\quad
    \href{https://github.com/\@cvgithub}{\faGithub~\@cvgithub} \\[4pt]
    \href{https://linkedin.com/in/\@cvlinkedin}{\faLinkedin~\@cvlinkedin} \quad\textbar\quad
    \href{https://scholar.google.com/citations?user=\@cvscholar}{\faGraduationCap~Google Scholar} \quad\textbar\quad
    \href{\@cvresearchgate}{\faFlask~ResearchGate}
  \end{center}
  \vspace{8pt}
}

%----- SECTION STYLING ---------------------------------------------------------
\titlespacing*{\section}{0pt}{2.5ex}{2ex}
\titleformat{\section}
  {\large\bfseries\color{primarycolor}}
  {}
  {0em}
  {}
  [\titlerule\vspace{-4pt}]
  

%----- CV ENTRY ENVIRONMENT ----------------------------------------------------
\newenvironment{cventries}{
  \begin{list}{}{\setlength{\leftmargin}{0em}\setlength{\itemsep}{4pt}}
}{
  \end{list}
}

\newcommand{\cventry}[4]{%
  \item
    \begin{tabular*}{\textwidth}{@{}p{0.7\textwidth} @{\extracolsep{\fill}} r@{}}
      \textbf{\large #1} & {\small\color{graytext} #4} \\
      \textit{\color{secondarycolor} #2} & \textit{\small\color{graytext} #3} \\
    \end{tabular*}
    \vspace{-6pt}
}

%----- PUBLICATION ENVIRONMENT -------------------------------------------------
\newcounter{pubcounter}
\newenvironment{cvpublications}{
  \setcounter{pubcounter}{0}
  \begin{list}{[\arabic{pubcounter}]}{\usecounter{pubcounter}\setlength{\leftmargin}{2.5em}\setlength{\itemsep}{2pt}}
}{
  \end{list}
}
\newcommand{\cvpublication}[4]{%
  \item
    #1. \textbf{#2}. \textit{#3}, #4.
}

%----- PROJECTS ENVIRONMENT ----------------------------------------------------
\newenvironment{cvprojects}{
  \begin{list}{}{\setlength{\leftmargin}{0em}\setlength{\itemsep}{2pt}}
}{
  \end{list}
  % \vspace{-3pt}
}
\newcommand{\cvproject}[2]{%
  \item
    \begin{tabular*}{\textwidth}{@{}p{0.9\textwidth} @{\extracolsep{\fill}} r@{}}
      \textbf{\large #1} & \href{#2}{\large\faGithub} \\
    \end{tabular*}
    \vspace{-8pt}
}

%----- SKILLS ENVIRONMENT ------------------------------------------------------
\newenvironment{cvskills}{
  \vspace{-2pt}
  \begin{tabular*}{\textwidth}{@{}p{0.2\textwidth} p{0.75\textwidth}@{}}
}{
  \end{tabular*}
}
\newcommand{\cvskill}[2]{%
  \textbf{\color{secondarycolor}#1} & #2 \\[4pt]
}


%----- DESCRIPTION ITEMS -------------------------------------------------------
\newenvironment{cvitems}{
  \begin{list}{\color{primarycolor}\textbullet}{\setlength{\leftmargin}{1.5em} \setlength{\itemsep}{-2pt} \setlength{\topsep}{0pt} \setlength{\partopsep}{0pt}}
    \vspace{-4pt}
}{
  \end{list}
}

\endinput
%----- END OF CLASS FILE -------------------------------------------------------
