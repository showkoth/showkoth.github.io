%-------------------------------------------------------------------------------
%                ACADEMIC CV - Custom LaTeX Class File
%-------------------------------------------------------------------------------
%
% Description:
% A custom LaTeX class for creating a professional, academic CV.
% Version 7.0: Serif typography, small-caps headers, refined academic layout.
%
%-------------------------------------------------------------------------------

%----- IDENTIFICATION ----------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{academic-cv}[2026/03/03 v7.0 Academic CV Class]

%----- BASE CLASS --------------------------------------------------------------
\LoadClass[11pt, a4paper]{article}

%----- REQUIRED PACKAGES -------------------------------------------------------
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
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
\usepackage{etaremune}  % For reverse-numbered lists

%----- FONT SETUP --------------------------------------------------------------
% Use Charter for body text (classic academic serif)
\usepackage[charter]{mathdesign}
\usepackage[scaled=0.95]{helvet}  % Helvetica for sans-serif elements

%----- GEOMETRY & LAYOUT -------------------------------------------------------
\geometry{
  left=1.8cm,
  right=1.8cm,
  top=1.5cm,
  bottom=2cm,
  footskip=1cm
}
\pagestyle{empty}

%----- COLORS & FONTS ----------------------------------------------------------
\definecolor{primarycolor}{HTML}{1a1a2e}
\definecolor{secondarycolor}{HTML}{2C3E50}
\definecolor{graytext}{HTML}{555555}
\definecolor{rulecolor}{HTML}{333333}

\hypersetup{
    colorlinks=true,
    urlcolor=black,
    linkcolor=black,
    citecolor=black,
}

%----- HEADER & FOOTER SETUP ---------------------------------------------------
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

% Define footer content (dynamic name)
\newcommand{\footerdate}[1]{\def\@footerdate{#1}}
\fancyfoot[L]{\footnotesize\color{graytext} \@footerdate}
\fancyfoot[C]{\footnotesize\color{graytext} \@cvname}
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
    {\LARGE\bfseries\scshape \@cvname}\\[6pt]
    {\small\color{secondarycolor}
    \faMapMarkerAlt~\@cvaddress \\[3pt]
    \faPhone~\@cvphone \quad\textbar\quad
    \href{mailto:\@cvemail}{\faEnvelope~\@cvemail} \quad\textbar\quad
    \href{http://\@cvsite}{\faGlobe~\@cvsite} \quad\textbar\quad
    \href{https://github.com/\@cvgithub}{\faGithub~\@cvgithub} \\[3pt]
    \href{https://linkedin.com/in/\@cvlinkedin}{\faLinkedin~\@cvlinkedin} \quad\textbar\quad
    \href{https://scholar.google.com/citations?user=\@cvscholar}{\faGraduationCap~Google Scholar} \quad\textbar\quad
    \href{\@cvresearchgate}{\faFlask~ResearchGate}}
  \end{center}
  \vspace{2pt}
  {\color{rulecolor}\hrule height 0.6pt}
  \vspace{6pt}
}

%----- SECTION STYLING ---------------------------------------------------------
\titlespacing*{\section}{0pt}{2ex}{1.5ex}
\titleformat{\section}
  {\large\bfseries\scshape\color{primarycolor}}
  {}
  {0em}
  {}
  [\vspace{-2pt}{\color{rulecolor}\titlerule[0.4pt]}\vspace{-4pt}]


%----- CV ENTRY ENVIRONMENT ----------------------------------------------------
\newenvironment{cventries}{
  \begin{list}{}{\setlength{\leftmargin}{0em}\setlength{\itemsep}{4pt}}
}{
  \end{list}
}

\newcommand{\cventry}[4]{%
  \item
    \begin{tabular*}{\textwidth}{@{}p{0.7\textwidth} @{\extracolsep{\fill}} r@{}}
      \textbf{#1} & {\small\color{graytext} #4} \\
      \textit{\color{secondarycolor} #2} & \textit{\small\color{graytext} #3} \\
    \end{tabular*}
    \vspace{-6pt}
}

%----- PUBLICATION ENVIRONMENT -------------------------------------------------
% Uses etaremune for reverse-numbered list
\newenvironment{cvpublications}{
  \begin{etaremune}[leftmargin=2.5em, itemsep=4pt, topsep=2pt]
}{
  \end{etaremune}
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
}
\newcommand{\cvproject}[2]{%
  \item
    \begin{tabular*}{\textwidth}{@{}p{0.9\textwidth} @{\extracolsep{\fill}} r@{}}
      \textbf{#1} & \href{#2}{\faGithub} \\
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
  \begin{list}{\textbullet}{\setlength{\leftmargin}{1.5em} \setlength{\itemsep}{-2pt} \setlength{\topsep}{0pt} \setlength{\partopsep}{0pt}}
    \vspace{-4pt}
}{
  \end{list}
}

\endinput
%----- END OF CLASS FILE -------------------------------------------------------
