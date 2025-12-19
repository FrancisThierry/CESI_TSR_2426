-- Colonnes : Id, Titre, Date, Description, Mots, Lien
CREATE TABLE FluxRSS (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Titre TEXT NOT NULL,
    DatePub DATETIME NOT NULL,
    Description TEXT,
    Mots INTEGER,
    Lien TEXT NOT NULL
);

