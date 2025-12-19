-- Colonnes : Id, Titre, Date, Mots, Lien
CREATE TABLE FluxRSS (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Titre TEXT NOT NULL,
    DatePub DATETIME NOT NULL,
    MotsCles TEXT,
    Lien TEXT NOT NULL
);
