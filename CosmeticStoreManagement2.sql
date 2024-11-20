CREATE DATABASE CosmeticStoreManagement3
GO

USE CosmeticStoreManagement3
GO

-- Bảng Users
CREATE TABLE [dbo].[tblUsers](
    [userID] [nvarchar](50) NOT NULL,
    [fullName] [nvarchar](50) NOT NULL,
    [password] [nvarchar](50) NOT NULL,
    [roleID] [nvarchar](50) NOT NULL,
    [status] [bit] NOT NULL,
    [isSale] [bit] NOT NULL DEFAULT 0,
    [picture] [nvarchar](50) NULL,
    [address] [nvarchar](MAX) NULL,
    CONSTRAINT [PK_tblUsers] PRIMARY KEY CLUSTERED ([userID] ASC)
)
GO

-- Bảng Categories
CREATE TABLE [dbo].[tblCategories] (
    [categoryID] [nvarchar](50) NOT NULL,
    [categoryName] [nvarchar](50) NOT NULL,
    CONSTRAINT [PK_tblCategories] PRIMARY KEY CLUSTERED ([categoryID] ASC)
)
GO

-- Bảng Products
CREATE TABLE [dbo].[tblProducts] (
    [productID] [nvarchar](50) NOT NULL,
    [productName] [nvarchar](50) NOT NULL,
    [price] [float] NOT NULL,
    [quantity] [int] NOT NULL,
    [status] [bit] NOT NULL,
    [image] [nvarchar](50) NULL,
    [description] [nvarchar](MAX) NULL,
    [categoryID] [nvarchar](50) NOT NULL,
    [saleID] [nvarchar](50) NULL,
    CONSTRAINT [PK_tblProducts] PRIMARY KEY CLUSTERED ([productID] ASC),
    CONSTRAINT [FK_tblProducts_tblUsers] FOREIGN KEY ([saleID]) REFERENCES [dbo].[tblUsers]([userID]),
    CONSTRAINT [FK_tblProducts_tblCategories] FOREIGN KEY ([categoryID]) REFERENCES [dbo].[tblCategories]([categoryID])
)
GO

-- Bảng Orders
CREATE TABLE [dbo].[tblOrders] (
    [orderID] [nvarchar](50) NOT NULL,
    [userID] [nvarchar](50) NOT NULL,
    [date] [datetime] NOT NULL,
    [total] [Money] NOT NULL,
    [status] [bit] NOT NULL,
    CONSTRAINT [PK_tblOrders] PRIMARY KEY CLUSTERED ([orderID] ASC),
    CONSTRAINT [FK_tblOrders_tblUsers] FOREIGN KEY ([userID]) REFERENCES [dbo].[tblUsers]([userID])
)
GO

-- Bảng OrderDetails
CREATE TABLE [dbo].[tblOrderDetails] (
    [orderID] [nvarchar](50) NOT NULL,
    [productID] [nvarchar](50) NOT NULL,
    [price] [Money] NOT NULL,
    [quantity] [int] NOT NULL,
    [status] [bit] NOT NULL,
    CONSTRAINT [PK_tblOrderDetails] PRIMARY KEY CLUSTERED ([orderID] ASC, [productID] ASC),
    CONSTRAINT [FK_tblOrderDetails_tblOrders] FOREIGN KEY ([orderID]) REFERENCES [dbo].[tblOrders]([orderID]),
    CONSTRAINT [FK_tblOrderDetails_tblProducts] FOREIGN KEY ([productID]) REFERENCES [dbo].[tblProducts]([productID])
)
GO

-- Chèn dữ liệu vào bảng Users
INSERT INTO [dbo].[tblUsers] (userID, fullName, password, roleID, status, isSale, picture, address)
VALUES 
('admin', N'Tôi là admin', '1', 'AD', 1, 0, NULL, NULL),
('SE140123', N'Nguyễn Văn A', '1', 'US', 1, 0, NULL, NULL),
('SE153212', N'Nguyễn Văn B', '1', 'US', 1, 0, NULL, NULL),
('SE164231', N'Nguyễn Văn C', '1', 'US', 1, 0, NULL, NULL),
('SE140124', N'Nguyễn Văn D', '1', 'US', 1, 0, NULL, NULL),
('SE140125', N'Nguyễn Văn E', '1', 'US', 1, 0, NULL, NULL),
('SE150126', N'Nguyễn Văn F', '1', 'US', 1, 0, NULL, NULL),
('SE170231', N'Nguyễn Văn G', '1', 'US', 1, 0, NULL, NULL),
('SE170235', N'Nguyễn Tuấn Anh', '1', 'US', 0, 0, NULL, NULL);
GO

-- Chèn dữ liệu vào bảng Categories
INSERT INTO [dbo].[tblCategories] (categoryID, categoryName)
VALUES 
('CAT001', 'Lip Products'),
('CAT002', 'Face Makeup'),
('CAT003', 'Eye Makeup'),
('CAT004', 'Fragrances');
GO

-- Chèn dữ liệu vào bảng Products
INSERT INTO [dbo].[tblProducts] (productID, productName, price, quantity, status, image, description, categoryID, saleID)
VALUES 
('P001', 'Lipstick', 100000, 100, 1, NULL, 'Matte Lipstick', 'CAT001', NULL),
('P002', 'Foundation', 200000, 50, 1, NULL, 'Full Coverage Foundation', 'CAT002', NULL),
('P003', 'Mascara', 150000, 75, 1, NULL, 'Volume Mascara', 'CAT003', NULL),
('P004', 'Eyeliner', 50000, 200, 1, NULL, 'Waterproof Eyeliner', 'CAT003', NULL),
('P005', 'Perfume', 300000, 120, 1, NULL, 'Luxury Perfume', 'CAT004', NULL);
GO

-- Chèn dữ liệu vào bảng Orders
INSERT INTO [dbo].[tblOrders] (orderID, userID, date, total, status)
VALUES 
('O001', 'SE140123', '2024-06-01', 300000, 1),
('O002', 'SE153212', '2024-06-02', 400000, 1),
('O003', 'SE164231', '2024-06-03', 600000, 1),
('O004', 'SE140124', '2024-06-04', 350000, 1),
('O005', 'SE140125', '2024-06-05', 400000, 1),
('O006', 'SE150126', '2024-06-06', 100000, 1),
('O007', 'SE170231', '2024-06-07', 200000, 1),
('O008', 'SE140123', '2024-06-08', 400000, 1),
('O009', 'SE153212', '2024-06-09', 550000, 1),
('O010', 'SE164231', '2024-06-10', 400000, 1);
GO

-- Chèn dữ liệu vào bảng OrderDetails
INSERT INTO [dbo].[tblOrderDetails] (orderID, productID, price, quantity, status)
VALUES 
('O001', 'P001', 100000, 1, 1),
('O001', 'P002', 200000, 1, 1),
('O002', 'P003', 150000, 2, 1),
('O002', 'P004', 50000, 2, 1),
('O003', 'P005', 300000, 2, 1),
('O004', 'P002', 200000, 1, 1),
('O004', 'P003', 150000, 1, 1),
('O005', 'P004', 50000, 2, 1),
('O005', 'P005', 300000, 1, 1),
('O006', 'P001', 100000, 1, 1),
('O007', 'P003', 150000, 1, 1),
('O007', 'P004', 50000, 1, 1),
('O008', 'P005', 300000, 1, 1),
('O008', 'P001', 100000, 1, 1),
('O009', 'P002', 200000, 2, 1),
('O009', 'P003', 150000, 1, 1),
('O010', 'P001', 100000, 1, 1),
('O010', 'P005', 300000, 1, 1);
GO