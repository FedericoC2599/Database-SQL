--Author: Federico Cianci
--Data: 18/12/2023
--Overview: Query che seleziona tutti gli attributi principali dei libri incluse le letture (completamenti) dell'autore
--          comprensive di data di inizio lettura, data di fine lettura e di un campo generato che calcola il numero
--          di giorni impiegati a leggere un libro della base di dati.
SELECT l.ID,l.Titolo,l.ISBN13,a.NomeAutore,a.CognomeAutore,a.NazionalitàAutore,l.AnnoPubblicazione,c.NomeCasaEditrice,e.NumeroEdizione,e.AnnoEdizione,li.LinguaLibro,li.LinguaOriginale,t.NomeTraduttore,t.CognomeTraduttore,cm.DataInizioLettura,cm.DataFineLettura,l.NumPagine,cm.PagineLette,(julianday(cm.DataFineLettura) - julianday(cm.DataInizioLettura)) AS GiorniCompletamento 
FROM Libri l
JOIN AutoriELibri al ON al.IDLibro = l.ID
JOIN Autori a ON a.IDAutore = al.IDAutore
JOIN Edizioni e ON e.IDLibro = l.ID
JOIN CaseEditrici c ON c.IDCasaEditrice = e.IDCasaEditrice
JOIN LingueTesto lt ON lt.IDLibro = l.ID
JOIN Lingue li ON lt.IDLingua = li.IDLingua
JOIN Traduzioni tr ON tr.IDLibro = l.ID
JOIN Traduttori t ON tr.IDTraduttore = t.IDTraduttore
JOIN CompletamentiLibri cml ON cml.IDLibro = l.ID
JOIN Completamenti cm ON cm.IDCompletamento = cml.IDCompletamento
ORDER BY l.Titolo ASC;